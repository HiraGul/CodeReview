import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';

import '../../../Utils/api_status_code.dart';
import '../../Repositories/login_repo.dart';
import 'login_state.dart';

class DriverLoginCubit extends Cubit<LoginState> {
  DriverLoginCubit() : super(LoginInitialState());

  tojjarLogin() async {
    emit(LoginLoadingState());

    var result = await TojjarLoginRepo().tujjarLoginUser();
    if (result == ApiStatusCode.ok) {
      AuthControllers.passwordController.clear();
      AuthControllers.phoneNumberController.clear();
      if (AuthControllers.userType == 'delivery_boy') {
        AuthControllers.userType == '';

        var topic =
            'driver-${AuthControllers.loginModelController!.user!.id.toString()}';
        await FirebaseMessaging.instance.subscribeToTopic(topic);
      }
      emit(LoginLoadedState());
    } else if (result == ApiStatusCode.socketException) {
      emit(LoginNoInternetState());
    } else if (result == ApiStatusCode.unAuthorized) {
      emit(LoginTokenExpireState());
    } else {
      emit(LoginErrorState("Bad Request"));
    }
  }
}
