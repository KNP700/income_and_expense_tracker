part of 'reset_password_page_bloc.dart';

@immutable
sealed class ResetPasswordPageState {}

final class ResetPasswordPageInitial extends ResetPasswordPageState {}

class ResetPasswordToLoginState extends ResetPasswordPageState{}

class ResetPasswordLoginButtonToLoginState extends ResetPasswordPageState{}
