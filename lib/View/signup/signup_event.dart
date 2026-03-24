part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupNavigateToSigninActionEvent extends SignupEvent {}


class SignupNavigateToOtpActionEvent extends SignupEvent{}
