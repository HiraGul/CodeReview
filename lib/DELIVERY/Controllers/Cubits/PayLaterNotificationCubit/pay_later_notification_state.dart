part of 'pay_later_notification_cubit.dart';

@immutable
abstract class PayLaterNotificationState {}

class PayLaterNotificationInitial extends PayLaterNotificationState {}

class PayLaterNotificationLoading extends PayLaterNotificationState {}

class PayLaterNotificationSuccess extends PayLaterNotificationState {}

class PayLaterNotificationFailed extends PayLaterNotificationState {}

class PayLaterNotificationNoInternet extends PayLaterNotificationState {}
