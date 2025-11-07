
import 'package:club8/Onboarding/recording_timer.dart';
import 'package:club8/Onboarding/submit_button.dart';
import 'package:club8/Onboarding/text_input_field.dart';
import 'package:club8/Onboarding/video_recorder_state.dart';
import 'package:club8/Onboarding/waveform_display.dart';
import 'package:flutter/material.dart';
import 'Models/constants.dart';
import 'audio_recorder_state.dart';
import 'control_buttons.dart';
import 'onboarding_page.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late OnboardingPageLogic _pageLogic;
  AudioRecorderState _audioState = AudioRecorderState.reset();
  VideoRecorderState _videoState = VideoRecorderState();

  @override
  void initState() {
    super.initState();
    _pageLogic = OnboardingPageLogic(
      onAudioStateChanged: _handleAudioStateChange,
      onVideoStateChanged: _handleVideoStateChange,
      onError: _handleError,
    );
  }

  @override
  void dispose() {
    _pageLogic.dispose();
    super.dispose();
  }

  /// Handle audio state changes
  void _handleAudioStateChange(AudioRecorderState state) {
    setState(() {
      _audioState = state;
    });
  }

  /// Handle video state changes
  void _handleVideoStateChange(VideoRecorderState state) {
    setState(() {
      _videoState = state;
    });
  }

  /// Handle errors and show snackbar
  void _handleError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Handle next button press
  void _handleNextButtonPress() {
    // TODO: Implement navigation to next screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Title
                          Text(
                            AppConstants.titleText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.titleFontSize,
                              color: AppConstants.textPrimaryColor,
                              fontFamily: AppConstants.fontFamily,
                            ),
                          ),

                          // Subtitle
                          Text(
                            AppConstants.subtitleText,
                            style: const TextStyle(
                              fontSize: AppConstants.subtitleFontSize,
                              color: AppConstants.textSecondaryColor,
                              fontFamily: AppConstants.fontFamily,
                            ),
                          ),

                          // Text input field
                          TextInputField(
                            hintText: AppConstants.textFieldHint,
                          ),

                          const SizedBox(height: AppConstants.largeSpacing),

                          // Waveform display
                          WaveformDisplay(
                            waveformData: _audioState.waveformData,
                            isRecording: _audioState.isRecording,
                          ),

                          // Recording timer
                          RecordingTimer(
                            durationInSeconds: _audioState.recordingDuration,
                            isRecording: _audioState.isRecording,
                          ),

                          // Video recording indicator
                          if (_videoState.isRecording)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(height: AppConstants.smallSpacing),
                                  Text(
                                    AppConstants.recordingVideoText,
                                    style: const TextStyle(
                                      color: AppConstants.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Video recorded indicator
                          if (_videoState.recordedVideo != null && !_videoState.isRecording)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                width: 200,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.borderRadius,
                                  ),
                                  border: Border.all(
                                    color: AppConstants.borderColor,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    AppConstants.videoRecordedText,
                                    style: TextStyle(
                                      color: AppConstants.textPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Control buttons and submit button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Recording controls
                              ControlButtons(
                                isAudioRecording: _audioState.isRecording,
                                isVideoRecording: _videoState.isRecording,
                                isMicAvailable: _pageLogic.isMicAvailable,
                                isVideoAvailable: _pageLogic.isVideoAvailable,
                                onMicTap: _audioState.isRecording
                                    ? _pageLogic.stopAudioRecording
                                    : _pageLogic.startAudioRecording,
                                onVideoTap: _videoState.isRecording
                                    ? _pageLogic.stopVideoRecording
                                    : _pageLogic.startVideoRecording,
                              ),

                              const SizedBox(width: AppConstants.largeSpacing),

                              // Submit button
                              SubmitButton(
                                onPressed: _handleNextButtonPress,
                                label: AppConstants.nextButtonText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            );
          },
        ),
      ),
    );
  }
}