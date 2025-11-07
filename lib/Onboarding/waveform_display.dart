import 'package:flutter/material.dart';
import 'package:club8/Onboarding/waveform_painter.dart';
import 'Models/constants.dart';

class WaveformDisplay extends StatelessWidget {
  final List<double> waveformData;
  final bool isRecording;

  const WaveformDisplay({
    super.key,
    required this.waveformData,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRecording) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        height: AppConstants.waveformHeight,
        width: AppConstants.waveformWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: AppConstants.borderColor,
            width: 1,
          ),
        ),
        child: CustomPaint(
          painter: WaveformPainter(waveformData),
        ),
      ),
    );
  }
}