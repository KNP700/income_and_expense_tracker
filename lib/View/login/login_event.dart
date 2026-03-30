part of 'login_bloc.dart';

abstract class LoginEvent {

}

class LoginNavigateToSignupActionEvent extends LoginEvent {

}


class LoginNavigateToForgotActionEvent extends LoginEvent{}


class LoginNavigateIntoHomeEvent extends LoginEvent{}


class LoginWithMobileToMobileEvent extends LoginEvent{}