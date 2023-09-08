import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/reset_password_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  sendOtp({required String phoneNumber}) async {
    emit(ResetPasswordLoading());

    // if (await InternetConnectivity.isNotConnected()) {
    //   await Future.delayed(const Duration(milliseconds: 200));
    //   emit(ResetPasswordNoInternet());
    //   return;
    // }

    try {
      var statusCode = await ResetPasswordRepo.sendOtp(
        phoneNumber: phoneNumber,
      );

      if (statusCode == ApiStatusCode.ok) {
        emit(ResetPasswordLoaded());
      } else {
        emit(
          ResetPasswordError(
            error: ApiStatusCode.getErrorMessage(statusCode: statusCode).message,
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(ResetPasswordNoInternet());
      } else {
        emit(
          ResetPasswordError(
            error: e.toString().contains('Exception:')
                ? e.toString().split('Exception:').last
                : e.toString(),
          ),
        );
      }
      // TODO
    }
  }

  verifyOtp({required String otp}) async {
    emit(ResetPasswordLoading());

    // if (await InternetConnectivity.isNotConnected()) {
    //   await Future.delayed(const Duration(milliseconds: 200));
    //   emit(ResetPasswordNoInternet());
    //   return;
    // }
    try {
      var statusCode = await ResetPasswordRepo.verifyOtp(otp: otp);
      if (statusCode == ApiStatusCode.ok) {
        emit(ResetPasswordLoaded());
      } else {
        emit(ResetPasswordError(
            error: ApiStatusCode.getErrorMessage(statusCode: statusCode).message));
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(ResetPasswordNoInternet());
      } else {
        emit(
          ResetPasswordError(
            error: e.toString().contains('Exception:')
                ? e.toString().split('Exception:').last
                : e.toString(),
          ),
        );
      }
      // TODO
    }
  }

  resetPassword({
    required String otp,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    // if (await InternetConnectivity.isNotConnected()) {
    //   await Future.delayed(const Duration(milliseconds: 200));
    //   emit(ResetPasswordNoInternet());
    //   return;
    // }
    try {
      var statusCode = await ResetPasswordRepo.resetPassword(
        otp: otp,
        confirmPassword: confirmPassword,
      );
      if (statusCode == ApiStatusCode.ok) {
        emit(ResetPasswordLoaded());
      } else {
        emit(
          ResetPasswordError(
            error: ApiStatusCode.getErrorMessage(
              statusCode: statusCode,
            ).message,
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(ResetPasswordNoInternet());
      } else {
        emit(
          ResetPasswordError(
            error: e.toString().contains('Exception:')
                ? e.toString().split('Exception:').last
                : e.toString(),
          ),
        );
      }
      // TODO
    }
  }





}
