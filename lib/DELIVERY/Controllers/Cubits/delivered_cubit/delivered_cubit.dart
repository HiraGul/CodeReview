import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/delivered_order_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/my_error_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'delivered_state.dart';

class DeliveredCubit extends Cubit<DeliveredState> {
  DeliveredCubit() : super(DeliveredInitial());

  getDeliver({required Map<String, dynamic> deliveryData, File? file}) async {
    emit(DeliveredLoading());

    try {
      var statusCode = await DeliverOrderRepo.deliverOrderRepo(
          deliveryData: deliveryData, file: file);

      if (statusCode == ApiStatusCode.ok) {
        emit(DeliveredLoaded());
      } else if (statusCode == ApiStatusCode.unAuthorized) {
        emit(DeliveredTokenExpire());
      } else {
        emit(
          DeliveredError(
            model: ApiStatusCode.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(DeliveredNoInternet());
      } else {
        emit(
          DeliveredError(
            model: MyErrorModel(
                statusCode: '',
                message: 'Something went wrong',
                description: e.toString()),
          ),
        );
      }
      // TODO
    }
  }
}
