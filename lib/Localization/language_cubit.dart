import 'package:bloc/bloc.dart';

class LoginSelectLanguageCubit extends Cubit<String> {
  LoginSelectLanguageCubit({required String initialState}) : super('English');
  selectLanguage({required String selectLanguage}) => emit(selectLanguage);
}
