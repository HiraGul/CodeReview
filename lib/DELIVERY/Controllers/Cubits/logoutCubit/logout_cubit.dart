import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/logoutCubit/logout_state.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/logout_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

import '../../../Utils/api_status_code.dart';

class DriverLogoutCubit extends Cubit<LogoutState> {
  DriverLogoutCubit() : super(LogoutInitialState());

  userLogout() async {
    emit(LogoutLoadingState());
    try {
      var result = await TojjarLogoutRepo().tujjarlogoutUser();
      if (result == ApiStatusCode.ok &&
          AuthControllers.logoutModelController.result == true) {
        LoginModel? loginModel = MySharedPrefs.getUser();
        if (loginModel!.user?.userType == 'delivery_boy') {
          MySharedPrefs.clearSharedPreferences();
        } else {
          MySharedPrefs.setUser(LoginModel());
        }

        emit(LogoutLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(LogoutNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(LogoutTokenExpireState());
      } else if (result == ApiStatusCode.notFound) {
        emit(LogoutNoDataState());
      }
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
