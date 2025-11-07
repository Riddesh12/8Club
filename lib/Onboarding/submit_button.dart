
import 'package:flutter/material.dart';
import 'Models/constants.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SubmitButton({
    super.key,
    required this.onPressed,
    this.label = AppConstants.nextButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.buttonHeight,
      width: AppConstants.buttonWidth,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.black26,
            Colors.white24,
            Colors.black12,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppConstants.borderColor,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.buttonFontSize,
              fontFamily: AppConstants.fontFamily,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}