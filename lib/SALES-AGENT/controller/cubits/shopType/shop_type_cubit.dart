import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/global_field_and_variable.dart';

class ShopTypeCubit extends Cubit<String> {
  ShopTypeCubit() : super('');

  changeShop(category) {
    if (category == 'Semi-wholesaler') {
      shopCategory.clear();
    }
    emit(category);
  }
}
