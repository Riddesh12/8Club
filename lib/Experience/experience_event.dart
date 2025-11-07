part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object?> get props => [];
}

class FetchExperiencesEvent extends ExperienceEvent {
  const FetchExperiencesEvent();
}

class ResetExperienceEvent extends ExperienceEvent {
  const ResetExperienceEvent();
}
