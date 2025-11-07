// lib/Onboarding/widgets/control_buttons.dart

import 'package:flutter/material.dart';
import 'Models/constants.dart';

class ControlButtons extends StatelessWidget {
  final bool isAudioRecording;
  final bool isVideoRecording;
  final bool isMicAvailable;
  final bool isVideoAvailable;
  final VoidCallback onMicTap;
  final VoidCallback onVideoTap;

  const ControlButtons({
    super.key,
    required this.isAudioRecording,
    required this.isVideoRecording,
    required this.isMicAvailable,
    required this.isVideoAvailable,
    required this.onMicTap,
    required this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppConstants.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (isMicAvailable)
            _buildMicButton(),
          if (isMicAvailable && isVideoAvailable)
            Container(
              width: 1,
              height: 48,
              color: AppConstants.dividerColor,
            ),
          if (isVideoAvailable)
            _buildVideoButton(),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    return InkWell(
      onTap: onMicTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isAudioRecording ? AppConstants.accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Icon(
          isAudioRecording ? Icons.stop : Icons.mic,
          color: isAudioRecording ? AppConstants.accentColor : AppConstants.textPrimaryColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildVideoButton() {
    return InkWell(
      onTap: onVideoTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isVideoRecording ? AppConstants.accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Icon(
          isVideoRecording ? Icons.stop : Icons.videocam,
          color: isVideoRecording ? AppConstants.accentColor : AppConstants.textPrimaryColor,
          size: 24,
        ),
      ),
    );
  }
}