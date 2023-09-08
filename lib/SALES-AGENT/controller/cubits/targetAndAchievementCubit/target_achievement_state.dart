abstract class TargetAchievementState {}

class TargetAchievementInitialState extends TargetAchievementState {}

class TargetAchievementLoadingState extends TargetAchievementState {}

class TargetAchievementLoadedState extends TargetAchievementState {}

class TargetAchievementNoInternetState extends TargetAchievementState {}

class TargetAchievementTokenExpireState extends TargetAchievementState {}

class TargetAchievementNoDataState extends TargetAchievementState {}

class TargetAchievementErrorState extends TargetAchievementState {
  String error;
  TargetAchievementErrorState(this.error);
}
