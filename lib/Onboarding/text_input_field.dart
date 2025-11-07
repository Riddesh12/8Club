

import 'package:flutter/material.dart';
import 'Models/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String hintText;
  final int maxLength;
  final int minLines;

  const TextInputField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = AppConstants.textFieldHint,
    this.maxLength = AppConstants.textMaxLength,
    this.minLines = AppConstants.textMinLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: AppConstants.textPrimaryColor),
        maxLength: maxLength,
        minLines: minLines,
        maxLines: null,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xFF1C1C1C),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
    );
  }
}