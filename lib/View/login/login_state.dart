part of 'login_bloc.dart';


sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginNavigateToSignupActionState extends LoginState {}
// class LoginFailed extends LoginState {
//   String get message => 'Failed!!';
// }
class LoginInProgress extends LoginState {}

class LoginNavigateToForgotActionState extends LoginState{}

class LoginNavigateIntoHomeState extends LoginState{
}