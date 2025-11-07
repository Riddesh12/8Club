// lib/Onboarding/models/recording_model.dart

class RecordingModel {
  final String filePath;
  final DateTime recordedAt;
  final int durationInSeconds;
  final String audioEncoder;

  RecordingModel({
    required this.filePath,
    required this.recordedAt,
    required this.durationInSeconds,
    this.audioEncoder = 'aacLc',
  });

  factory RecordingModel.empty() {
    return RecordingModel(
      filePath: '',
      recordedAt: DateTime.now(),
      durationInSeconds: 0,
    );
  }

  bool get isEmpty => filePath.isEmpty;

  @override
  String toString() => 'RecordingModel(filePath: $filePath, duration: $durationInSeconds)';
}