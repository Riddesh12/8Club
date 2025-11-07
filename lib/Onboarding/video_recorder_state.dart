import 'package:flutter/foundation.dart';

class VideoRecorderState {
  final bool isRecording;

  final bool isInitialized;

  final dynamic recordedVideo;

  const VideoRecorderState({
    this.isRecording = false,
    this.isInitialized = false,
    this.recordedVideo,
  });
  static VideoRecorderState reset() {
    return const VideoRecorderState(
      isRecording: false,
      isInitialized: false,
      recordedVideo: null,
    );
  }

  VideoRecorderState copyWith({
    bool? isRecording,
    bool? isInitialized,
    dynamic recordedVideo,
  }) {
    return VideoRecorderState(
      isRecording: isRecording ?? this.isRecording,
      isInitialized: isInitialized ?? this.isInitialized,
      recordedVideo: recordedVideo ?? this.recordedVideo,
    );
  }

  @override
  String toString() {
    return 'VideoRecorderState(isRecording: $isRecording, '
        'isInitialized: $isInitialized, '
        'recordedVideo: ${recordedVideo != null})';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VideoRecorderState &&
            other.isRecording == isRecording &&
            other.isInitialized == isInitialized &&
            other.recordedVideo == recordedVideo);
  }

  @override
  int get hashCode =>
      isRecording.hashCode ^
      isInitialized.hashCode ^
      recordedVideo.hashCode;
}
