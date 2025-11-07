// lib/Onboarding/models/video_model.dart

class VideoModel {
  final String filePath;
  final DateTime recordedAt;
  final String? thumbnail;

  VideoModel({
    required this.filePath,
    required this.recordedAt,
    this.thumbnail,
  });

  factory VideoModel.empty() {
    return VideoModel(
      filePath: '',
      recordedAt: DateTime.now(),
    );
  }

  bool get isEmpty => filePath.isEmpty;

  @override
  String toString() => 'VideoModel(filePath: $filePath)';
}