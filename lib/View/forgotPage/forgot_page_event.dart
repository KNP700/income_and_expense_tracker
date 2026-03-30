part of 'forgot_page_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordNavigateToSigninActionEvent extends ForgotPasswordEvent {}

class ForgotPasswordToOtpPageEvent extends ForgotPasswordEvent{}
