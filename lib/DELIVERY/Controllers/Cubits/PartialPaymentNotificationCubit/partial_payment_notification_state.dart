part of 'partial_payment_notification_cubit.dart';

@immutable
abstract class PartialPaymentNotificationState {}

class PartialPaymentNotificationInitial
    extends PartialPaymentNotificationState {}

class PartialPaymentNotificationLoading
    extends PartialPaymentNotificationState {}

class PartialPaymentNotificationSuccess
    extends PartialPaymentNotificationState {}

class PartialPaymentNotificationFailed
    extends PartialPaymentNotificationState {}

class PartialPaymentNotificationNoInternet
    extends PartialPaymentNotificationState {}
