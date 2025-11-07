

import 'dart:async';
import 'dart:math';
import 'package:club8/Onboarding/video_recorder_state.dart';
import 'Services/audio_service.dart';
import 'Services/permission_service.dart';
import 'Services/video_service.dart';
import 'audio_recorder_state.dart';
import 'Models/constants.dart';

class OnboardingPageLogic {
  // Audio recording state
  AudioRecorderState audioState = AudioRecorderState.reset();
  VideoRecorderState videoState = VideoRecorderState();
  bool isMicAvailable = true;
  bool isVideoAvailable = true;

  // Services
  late AudioService audioService;
  late VideoService videoService;

  // Timers
  Timer? amplitudeTimer;
  Timer? durationTimer;

  // Callbacks
  final Function(AudioRecorderState) onAudioStateChanged;
  final Function(VideoRecorderState) onVideoStateChanged;
  final Function(String) onError;

  OnboardingPageLogic({
    required this.onAudioStateChanged,
    required this.onVideoStateChanged,
    required this.onError,
  }) {
    audioService = AudioService();
    videoService = VideoService();
  }

  /// Start audio recording
  Future<void> startAudioRecording() async {
    final permissionGranted = await PermissionService.requestMicrophonePermission();
    if (!permissionGranted) {
      onError(AppConstants.permissionDeniedText);
      return;
    }

    try {
      await audioService.startRecording();

      audioState = audioState.copyWith(
        isRecording: true,
        waveformData: List.generate(40, (index) => 0.1),
        recordingDuration: 0,
      );
      onAudioStateChanged(audioState);

      _startDurationTimer();
      _startAmplitudeTimer();
    } catch (e) {
      onError('${AppConstants.errorPrefix}$e');
    }
  }

  /// Stop audio recording
  Future<void> stopAudioRecording() async {
    try {
      final path = await audioService.stopRecording();
      amplitudeTimer?.cancel();
      durationTimer?.cancel();

      audioState = AudioRecorderState.reset();
      onAudioStateChanged(audioState);

      if (path != null) {
        onError('${AppConstants.recordingSavedText}: $path');
        isMicAvailable = false;
      }
    } catch (e) {
      onError('${AppConstants.errorPrefix}$e');
    }
  }

  /// Start video recording
  Future<void> startVideoRecording() async {
    final permissionGranted = await PermissionService.requestCameraAndMicrophonePermission();
    if (!permissionGranted) {
      if (!await PermissionService.isCameraPermissionGranted()) {
        onError(AppConstants.cameraPermissionDeniedText);
      } else {
        onError(AppConstants.micPermissionDeniedText);
      }
      return;
    }

    try {
      await videoService.initializeCamera();
      await videoService.startVideoRecording();

      videoState = videoState.copyWith(
        isRecording: true,
        isInitialized: true,
      );
      onVideoStateChanged(videoState);
    } catch (e) {
      onError('${AppConstants.errorPrefix}$e');
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      final videoFile = await videoService.stopVideoRecording();
      videoService.dispose();

      if (videoFile != null) {
        final videoModel = videoService.createVideoModel(videoFile: videoFile);
        videoState = videoState.copyWith(
          isRecording: false,
          recordedVideo: videoModel,
        );
        onVideoStateChanged(videoState);
        onError(AppConstants.videoSavedText);

        Future.delayed(const Duration(seconds: 1), () {
          videoState = VideoRecorderState.reset();
          isVideoAvailable = false;
          onVideoStateChanged(videoState);
        });
      }
    } catch (e) {
      onError('${AppConstants.errorPrefix}$e');
    }
  }

  void _startDurationTimer() {
    durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      audioState = audioState.copyWith(
        recordingDuration: audioState.recordingDuration + 1,
      );
      onAudioStateChanged(audioState);
    });
  }
  void _startAmplitudeTimer() {
    amplitudeTimer = Timer.periodic(
      const Duration(milliseconds: AppConstants.amplitudeUpdateIntervalMs),
          (timer) async {
        final amplitude = await audioService.getAmplitude();
        double value = amplitude;

        if (value == 0 || value.isNaN) {
          value = Random().nextDouble() * 0.5 + 0.2;
        }

        final updatedWaveform = List<double>.from(audioState.waveformData);
        updatedWaveform.removeAt(0);
        updatedWaveform.add(value.clamp(0.1, 1.0));

        audioState = audioState.copyWith(waveformData: updatedWaveform);
        onAudioStateChanged(audioState);
      },
    );
  }

  void dispose() {
    amplitudeTimer?.cancel();
    durationTimer?.cancel();
    audioService.dispose();
    videoService.dispose();
  }
}