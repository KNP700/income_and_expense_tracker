part of 'reset_password_page_bloc.dart';

@immutable
sealed class ResetPasswordPageEvent {}


class ResetPasswordToLoginEvent extends ResetPasswordPageEvent{}

class ResetPasswordLoginButtonToLoginEvent extends ResetPasswordPageEvent{}
