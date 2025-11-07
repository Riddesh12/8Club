// lib/Onboarding/services/video_service.dart

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/video_model.dart';
import '../duration_formatter.dart';

class VideoService {
  CameraController? _cameraController;
  String? _videoPath;

  CameraController? get cameraController => _cameraController;
  String? get videoPath => _videoPath;
  bool get isVideoRecording => _cameraController?.value.isRecordingVideo ?? false;

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

      final CameraDescription camera = cameras.first;
      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: true,
      );
      await _cameraController!.initialize();
    } catch (e) {
      rethrow;
    }
  }


  Future<void> startVideoRecording() async {
    try {
      if (_cameraController == null) {
        await initializeCamera();
      }

      if (_cameraController != null && !_cameraController!.value.isRecordingVideo) {
        final dir = await getApplicationDocumentsDirectory();
        _videoPath = '${dir.path}/video_${DurationFormatter.getTimestamp()}.mp4';
        await _cameraController!.startVideoRecording();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Stop video recording and return video file
  Future<XFile?> stopVideoRecording() async {
    try {
      if (_cameraController != null && _cameraController!.value.isRecordingVideo) {
        XFile videoFile = await _cameraController!.stopVideoRecording();
        return videoFile;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Create video model from XFile
  VideoModel createVideoModel({required XFile videoFile}) {
    return VideoModel(
      filePath: videoFile.path,
      recordedAt: DateTime.now(),
    );
  }

  /// Dispose camera controller
  void dispose() {
    _cameraController?.dispose();
    _cameraController = null;
  }
}