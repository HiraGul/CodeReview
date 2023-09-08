import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/addCustomerCubit/add_customer_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/cityListCubit/city_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/countryListCubit/country_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/districtListCubit/district_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer1_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentApproveCubit/partial_payment_approve_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentRejectCubit/partial_payment_reject_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/payLaterRequestRejectCubit/pay_later_request_reject_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/stateListCubit/state_list_cubit.dart';

import '../../../SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/allCustomerCubit/all_customer_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/allOrderCubit/all_order_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/checkInCubit/checkin_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/checkOutCubit/checkout_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/customerCheckinCubit/customer_checkin_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/customerDetailCubit/customer_detail_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/getCheckInCubit/get_checkin_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/orderDetailCubit/order_detail_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/payLaterRequestApprovCubit/pay_later_request_approve_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/pendingRequestCubit/pending_request_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/requestHistoryCubit/request_history_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/shopType/shop_type_cubit.dart';
import '../../../SALES-AGENT/controller/cubits/targetAndAchievementCubit/target_achievement_cubit.dart';

final saleAGent = [
  BlocProvider<ShopTypeCubit>(create: (_) => ShopTypeCubit()),
  BlocProvider<AgentDashboardCubit>(create: (context) => AgentDashboardCubit()),
  BlocProvider<AllCustomerCubit>(create: (context) => AllCustomerCubit()),
  BlocProvider<CustomerDetailCubit>(create: (context) => CustomerDetailCubit()),
  BlocProvider<TargetAchievementCubit>(
      create: (context) => TargetAchievementCubit()),
  BlocProvider<PendingRequestCubit>(create: (context) => PendingRequestCubit()),
  BlocProvider<RequestHistoryCubit>(create: (context) => RequestHistoryCubit()),
  BlocProvider<OrderDetailCubit>(create: (context) => OrderDetailCubit()),
  BlocProvider<AllOrderCubit>(create: (context) => AllOrderCubit()),
  BlocProvider<TargetAchievementCubit>(
      create: (context) => TargetAchievementCubit()),
  BlocProvider<AddCustomerCubit>(create: (context) => AddCustomerCubit()),
  BlocProvider<CountryListCubit>(create: (context) => CountryListCubit()),
  BlocProvider<DistrictListCubit>(create: (context) => DistrictListCubit()),
  BlocProvider<CityListCubit>(create: (context) => CityListCubit()),
  BlocProvider<StateListCubit>(create: (context) => StateListCubit()),
  BlocProvider<CustomerCheckInCubit>(
      create: (context) => CustomerCheckInCubit()),
  BlocProvider<CheckInCubit>(create: (context) => CheckInCubit()),
  BlocProvider<GetCheckInCubit>(create: (context) => GetCheckInCubit()),
  BlocProvider<CheckOutCubit>(create: (context) => CheckOutCubit()),
  BlocProvider<PayLaterRequestApproveCubit>(
      create: (context) => PayLaterRequestApproveCubit()),
  BlocProvider<PayLaterRequestRejectCubit>(
      create: (context) => PayLaterRequestRejectCubit()),
  BlocProvider<LoginAsCustomerCubit>(
      create: (context) => LoginAsCustomerCubit()),
  BlocProvider<LoginAsCustomer1Cubit>(
      create: (context) => LoginAsCustomer1Cubit()),
  BlocProvider<PartialPendingRequestCubit>(
      create: (context) => PartialPendingRequestCubit()),
  BlocProvider<PartialHistoryRequestCubit>(
      create: (context) => PartialHistoryRequestCubit()),
  BlocProvider<PartialPaymentApproveCubit>(
      create: (context) => PartialPaymentApproveCubit()),
  BlocProvider<PartialPaymentRejectCubit>(
      create: (context) => PartialPaymentRejectCubit())
];
