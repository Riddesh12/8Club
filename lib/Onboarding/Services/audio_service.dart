

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../Models/recording_model.dart';
import '../duration_formatter.dart';

class AudioService {
  final AudioRecorder _audioRecorder = AudioRecorder();

  AudioRecorder get audioRecorder => _audioRecorder;

  // Start audio recording
  Future<String?> startRecording() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'recording_${DurationFormatter.getTimestamp()}.m4a';
      final filePath = '${dir.path}/$fileName';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: filePath,
      );

      return filePath;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      return path;
    } catch (e) {
      rethrow;
    }
  }

  Future<double> getAmplitude() async {
    try {
      final amplitude = await _audioRecorder.getAmplitude();
      return amplitude.current.abs() / 100;
    } catch (e) {
      return 0.0;
    }
  }

  Future<bool> Function() get isRecording => _audioRecorder.isRecording;

  void dispose() {
    _audioRecorder.dispose();
  }

  RecordingModel createRecordingModel({
    required String filePath,
    required int durationInSeconds,
  }) {
    return RecordingModel(
      filePath: filePath,
      recordedAt: DateTime.now(),
      durationInSeconds: durationInSeconds,
    );
  }
}