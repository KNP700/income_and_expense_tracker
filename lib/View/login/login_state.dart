part of 'login_bloc.dart';


 class LoginState {}

class LoginInitial extends LoginState {}

class LoginNavigateToSignupActionState extends LoginState {}
class LoginFailed extends LoginState {
  String get message => 'Failed!!';
}
class LoginInProgress extends LoginState {}

class LoginNavigateToForgotActionState extends LoginState{}

class LoginNavigateIntoHomeState extends LoginState{
}

class  LoginWithMobileToMobileState extends LoginState{}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}