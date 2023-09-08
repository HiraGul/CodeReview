import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/targetAndAchievementCubit/target_achievement_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/target_and_achievements_repo.dart';

class TargetAchievementCubit extends Cubit<TargetAchievementState> {
  TargetAchievementCubit() : super(TargetAchievementInitialState());

  fetchTargetAchievementData() async {
    emit(TargetAchievementLoadingState());
    try {
      var result =
          await TargetAndAchievementsRepo().getTargetAchievementsData();
      if (result == ApiStatusCode.ok) {
        emit(TargetAchievementLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(TargetAchievementNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(TargetAchievementTokenExpireState());
      } else if (result == 00) {
        emit(TargetAchievementNoDataState());
      }
    } catch (e) {
      emit(TargetAchievementErrorState(e.toString()));
    }
  }
}
