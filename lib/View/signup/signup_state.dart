part of 'signup_bloc.dart';

// sealed class SignupState {}

class SignupInitial extends SignupState {}

class SignupNavigateToSigninActionState extends SignupState {}

class SignupNavigateToOtpActionState extends SignupState {}

class SignupLoadingState extends SignupState {

  
}

class SignupErrorState extends SignupState {
  final String errorMessage;
  const SignupErrorState(this.errorMessage);
}

class SignupEmailLinkSentState extends SignupState {
  final String email;
  const SignupEmailLinkSentState(this.email);
}


enum SignupStep { email, otp, details }

class SignupState extends Equatable {
  final SignupStep step;
  final String email;
  final String generatedOtp;
  final String errorMessage;
  final bool isLoading;

  const SignupState({
    this.step = SignupStep.email,
    this.email = '',
    this.generatedOtp = '',
    this.errorMessage = '',
    this.isLoading = false,
  });

  SignupState copyWith({
    SignupStep? step,
    String? email,
    String? generatedOtp,
    String? errorMessage,
    bool? isLoading,
  }) {
    return SignupState(
      step: step ?? this.step,
      email: email ?? this.email,
      generatedOtp: generatedOtp ?? this.generatedOtp,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }






  @override
  List<Object> get props =>
      [step, email, generatedOtp, errorMessage, isLoading];
}
