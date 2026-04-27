part of 'mobile_otp_page_bloc.dart';

@immutable
 class MobileOtpPageEvent {}

class SignupVerifyOtpEvent extends MobileOtpPageEvent {
  final String verificationId;
  final String otpCode;


  SignupVerifyOtpEvent({
    required this.verificationId,
    required this.otpCode,
  });

}

class AfterMobileOtpNavigationEvent extends MobileOtpPageEvent{}

