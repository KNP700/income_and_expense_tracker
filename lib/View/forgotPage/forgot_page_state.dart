part of 'forgot_page_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordNavigateToSigninActionState extends ForgotPasswordState{}

class ForgotPasswordToOtpPageState extends ForgotPasswordState{}