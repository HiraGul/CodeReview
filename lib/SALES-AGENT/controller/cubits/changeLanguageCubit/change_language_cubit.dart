import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageCubit extends Cubit<String> {
  ChangeLanguageCubit() : super("English");

  changeLanguage(language) {
    emit(language);
  }
}
