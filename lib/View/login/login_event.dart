part of 'login_bloc.dart';

abstract class LoginEvent {

}

class LoginNavigateToSignupActionEvent extends LoginEvent {

}


class LoginNavigateToForgotActionEvent extends LoginEvent{}


class LoginNavigateIntoHomeEvent extends LoginEvent{}


class LoginWithMobileToMobileEvent extends LoginEvent{}


class GoogleSignInEvent extends LoginEvent {}


class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({
    required this.email,
    required this.password,
  });
}