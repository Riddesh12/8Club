// lib/Onboarding/utils/constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color backgroundColor = Colors.black;
  static const Color textPrimaryColor = Colors.white;
  static const Color textSecondaryColor = Colors.grey;
  static const Color accentColor = Colors.red;
  static const Color borderColor = Colors.white24;
  static const Color dividerColor = Colors.white24;

  // Font families
  static const String fontFamily = "SpaceGrotesk";

  // Font sizes
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 15.0;
  static const double buttonFontSize = 20.0;
  static const double timerFontSize = 24.0;

  // Padding and spacing
  static const double defaultPadding = 10.0;
  static const double largeSpacing = 20.0;
  static const double smallSpacing = 10.0;

  // Dimensions
  static const double waveformHeight = 100.0;
  static const double waveformWidth = 300.0;
  static const double buttonHeight = 50.0;
  static const double buttonWidth = 200.0;
  static const double borderRadius = 10.0;

  // Duration and timers
  static const int amplitudeUpdateIntervalMs = 100;
  static const int durationUpdateIntervalSec = 1;

  // Audio recording config
  static const int audioSampleRate = 44100;
  static const int audioBitRate = 128000;

  // Text constraints
  static const int textMaxLength = 600;
  static const int textMinLines = 10;

  // UI strings
  static const String titleText = "Why do you want to host with us?";
  static const String subtitleText = "Tell us about your intent and what motivates you to create experience";
  static const String textFieldHint = "/ Start typing here";
  static const String nextButtonText = "Next";
  static const String recordingVideoText = "Recording Video...";
  static const String videoRecordedText = "Video Recorded";
  static const String permissionDeniedText = "Denied Permissions";
  static const String cameraPermissionDeniedText = "Camera permission denied";
  static const String micPermissionDeniedText = "Mic permission denied";
  static const String recordingSavedText = "Recording saved";
  static const String videoSavedText = "Video saved";
  static const String errorPrefix = "Error: ";
}