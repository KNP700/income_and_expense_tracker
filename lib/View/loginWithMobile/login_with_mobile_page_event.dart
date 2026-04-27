part of 'login_with_mobile_page_bloc.dart';

@immutable
 class LoginWithMobilePageEvent {}

class MobilePageToOtpEvent extends LoginWithMobilePageEvent {}

class PhoneNumberEntered extends LoginWithMobilePageEvent {
  final String phoneNumber;

  PhoneNumberEntered({required this.phoneNumber});
}


class PhoneNumberSubmitted extends LoginWithMobilePageEvent{
  final String phone;

  PhoneNumberSubmitted(this.phone);

}