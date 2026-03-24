part of 'login_bloc.dart';


sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginNavigateToSignupActionState extends LoginState {}

class LoginNavigateToForgotActionState extends LoginState{}