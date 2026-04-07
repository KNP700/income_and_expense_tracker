part of 'login_with_mobile_page_bloc.dart';

@immutable
sealed class LoginWithMobilePageState {}

final class LoginWithMobilePageInitial extends LoginWithMobilePageState {}

class MobilePageToOtpState extends LoginWithMobilePageState{
  final String verificationId;
  MobilePageToOtpState({required this.verificationId});
}


class MobilePageLoadingState extends LoginWithMobilePageState{}

class MobilePageErrorState extends LoginWithMobilePageState{
  MobilePageErrorState(String s);
}