import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc() : super(const ExperienceInitial()) {
    on<FetchExperiencesEvent>(_onFetchExperiences);
    on<ResetExperienceEvent>(_onResetExperience);
  }

  Future<void> _onFetchExperiences(
      FetchExperiencesEvent event,
      Emitter<ExperienceState> emit,
      ) async {
    emit(const ExperienceLoading());
    try {
      final response = await http.get(
        Uri.parse('https://staging.chamberofsecrets.8club.co/v1/experiences?active=true'),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map &&
            data.containsKey('data') &&
            data['data'] is Map &&
            data['data'].containsKey('experience')) {
          final experiences = data['data']['experience'] as List<dynamic>;
          emit(ExperienceLoaded(experiences: experiences));
        } else {
          emit(const ExperienceError(message: 'Invalid response format'));
        }
      } else {
        emit(ExperienceError(
          message: 'Failed to load experiences. Status: ${response.statusCode}',
        ));
      }
    } on http.ClientException {
      emit(const ExperienceError(message: 'Network error. Please check your connection.'));
    } catch (e) {
      emit(ExperienceError(message: 'Error: ${e.toString()}'));
    }
  }

  Future<void> _onResetExperience(
      ResetExperienceEvent event,
      Emitter<ExperienceState> emit,
      ) async {
    emit(const ExperienceInitial());
  }
}
