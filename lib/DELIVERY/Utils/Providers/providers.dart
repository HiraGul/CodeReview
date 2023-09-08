import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/ShowPasswordCubit/show_password_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/loginCubit/login_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/logoutCubit/logout_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/Providers/sale_agent.dart';
import 'package:tojjar_delivery_app/Localization/language_cubit.dart';

import 'drivers.dart';

class MyProviders {
  static List<BlocProvider<dynamic>> initialize() {
    List<BlocProvider<dynamic>> cubitList = [
      BlocProvider<DriverLoginCubit>(create: (context) => DriverLoginCubit()),
      BlocProvider<DriverLogoutCubit>(create: (context) => DriverLogoutCubit()),
      BlocProvider<EyeCubit>(
        create: (context) => EyeCubit(true),
      ),
      BlocProvider<ResetPasswordCubit>(
        create: (context) => ResetPasswordCubit(),
      ),
      BlocProvider<LoginSelectLanguageCubit>(
        create: (context) => LoginSelectLanguageCubit(initialState: 'English'),
      ),
    ];
    cubitList.addAll(saleAGent);

    cubitList.addAll(drivers);

    return cubitList;
  }
}
