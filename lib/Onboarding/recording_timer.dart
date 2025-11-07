

import 'package:flutter/material.dart';
import 'Services/time_formatter.dart' as DurationFormatter;
import 'Models/constants.dart';

class RecordingTimer extends StatelessWidget {
  final int durationInSeconds;
  final bool isRecording;

  const RecordingTimer({
    super.key,
    required this.durationInSeconds,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRecording) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        DurationFormatter.formatDuration(durationInSeconds),
        style: const TextStyle(
          color: AppConstants.textPrimaryColor,
          fontSize: AppConstants.timerFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}