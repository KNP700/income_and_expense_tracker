part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupNavigateToSigninActionEvent extends SignupEvent {}


class SignupNavigateToOtpActionEvent extends SignupEvent{}

class SignupEmailSubmittedEvent extends SignupEvent {
  final String email;

  SignupEmailSubmittedEvent({required this.email});
}

// class SignupEvent extends Equatable {
//   List<Object> get props => [];
// }

class EmailSubmitted extends SignupEvent {
  final String email;

  EmailSubmitted(this.email);
}

class OtpVertified extends SignupEvent {
  final String otpInput;

  OtpVertified(this.otpInput);
}