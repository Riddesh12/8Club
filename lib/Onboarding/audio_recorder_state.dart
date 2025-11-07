import 'package:flutter/foundation.dart';

/// Represents the current state of the audio recorder.
class AudioRecorderState {
  /// Whether the recorder is currently recording audio.
  final bool isRecording;

  /// Duration of the current or last recording (in seconds).
  final int recordingDuration;

  /// List of waveform amplitude values for visualizing the audio.
  final List<double> waveformData;

  const AudioRecorderState({
    required this.isRecording,
    required this.recordingDuration,
    required this.waveformData,
  });

  /// ✅ Static factory method to return the initial "reset" state.
  static AudioRecorderState reset() {
    return const AudioRecorderState(
      isRecording: false,
      recordingDuration: 0,
      waveformData: [],
    );
  }

  /// Creates a copy of the current state with optional changes.
  AudioRecorderState copyWith({
    bool? isRecording,
    int? recordingDuration,
    List<double>? waveformData,
  }) {
    return AudioRecorderState(
      isRecording: isRecording ?? this.isRecording,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      waveformData: waveformData ?? this.waveformData,
    );
  }

  @override
  String toString() {
    return 'AudioRecorderState(isRecording: $isRecording, '
        'recordingDuration: $recordingDuration, '
        'waveformData length: ${waveformData.length})';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AudioRecorderState &&
            other.isRecording == isRecording &&
            other.recordingDuration == recordingDuration &&
            listEquals(other.waveformData, waveformData));
  }

  @override
  int get hashCode =>
      isRecording.hashCode ^
      recordingDuration.hashCode ^
      waveformData.hashCode;
}
