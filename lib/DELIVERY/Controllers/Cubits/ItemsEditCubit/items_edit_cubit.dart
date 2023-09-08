import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsEdit extends Cubit<List<int>> {
  ItemsEdit(super.initialState);

  changedItemValue({
    required List<int> items,
  }) {
    print("Quantity Before Emitting $items");

    emit(items);
    print("Quantity After Emitting $items");
  }
}
