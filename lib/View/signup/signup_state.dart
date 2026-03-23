part of 'signup_bloc.dart';


sealed class SignupState {}

class SignupInitial extends SignupState {}

class SignupNavigateToSigninActionState extends SignupState{}
