import 'package:flutter/material.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/AuthenticationScreens/ForgotPassword/forgot_password.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/AuthenticationScreens/LoginScreen/login_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/AuthenticationScreens/OTPScreen/otp_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/ChangePasswordScreen/change_password_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/DeliveryDetailScreen/delivery_details_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/DeliveryHomeScreen/delivery_home_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/InvoiceDetailsScreen/invoice_details_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/PickedAssignedOrders/picked_assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SplashScreen/splash_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SummaryScreen/summary_screen.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/addCustomer/add_customer.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/allCustomer/customers.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/allOrders/all_orders_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/orderDetail/order_detail_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/partialPayRequestView/partial_pay_request_approval_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/partialPayRequestView/partial_pay_request_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/pay_later_request_approval_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/pay_later_request_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/saleAgentDashboard/sale_agent_dashboard.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/singleCustomer/single_customer_detail.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/targetAcheivement/target_acheivement_view.dart';

var customRoutes = <String, WidgetBuilder>{
  // Delivery Routes
  Strings.splashScreen: (context) => const SplashScreen(),
  Strings.loginScreen: (context) => const LoginScreen(),
  Strings.changePasswordScreen: (context) => ChangePasswordScreen(),
  Strings.deliveryHomeScreen: (context) => const DeliveryHomeScreen(),
  Strings.forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
  Strings.assignedAndPickedOrders: (context) => const AssignedAndPickedOrders(
        pageValue: 0,
      ),
  Strings.otpScreen: (context) => const OtpScreen(),
  Strings.deliveryDetailsScreen: (context) => const DeliveryDetailScreen(),
  Strings.invoiceDetailsScreen: (context) => const InvoiceDetailScreen(),
  Strings.signatureScreen: (context) => const ESignatureScreen(),
  Strings.summaryScreen: (context) => const SummaryScreen(),

  // Sale Agent Routes
  Strings.addCustomer: (context) => const AddCustomer(),
  Strings.allOrders: (context) => const AllOrdersView(),
  Strings.customers: (context) => const AllCustomersView(),
  Strings.orderDetail: (context) => const OrderDetailView(),
  Strings.payLaterRequest: (context) => const PayLaterRequestView(),
  Strings.payLaterRequestApproval: (context) => PayLaterRequestApprovalView(),
  Strings.saleAgentDashboard: (context) => const SaleAgentDashBoard(),
  Strings.singleCustomerDetail: (context) => const SingleCustomerDetail(),
  Strings.targetAcheivement: (context) => const TargetAcheivementView(),
  Strings.partialPayRequest: (context) => const PartialPayRequestView(),
  Strings.partialPayRequestApproval: (context) =>
      PartialPayRequestApprovalView()
};
