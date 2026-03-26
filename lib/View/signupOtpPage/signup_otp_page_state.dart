part of 'signup_otp_page_bloc.dart';

@immutable
sealed class SignupOtpPageState {}

final class SignupOtpPageInitial extends SignupOtpPageState {}

class ContinueToCreateAccActionState extends SignupOtpPageState{}