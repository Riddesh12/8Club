// lib/Onboarding/services/permission_service.dart

import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }
  static Future<bool> requestCameraAndMicrophonePermission() async {
    final cameraGranted = await requestCameraPermission();
    final micGranted = await requestMicrophonePermission();
    return cameraGranted && micGranted;
  }

  static Future<bool> isMicrophonePermissionGranted() async {
    final status = await Permission.microphone.status;
    return status == PermissionStatus.granted;
  }

  static Future<bool> isCameraPermissionGranted() async {
    final status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }
}