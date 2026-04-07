import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';
import 'package:income_and_expense_tracker/View/login/login_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/auth_repository.dart';


part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(const SignupState()) {
    // on<EmailSubmitted>((event, emit) async {
    //   emit(state.copyWith(isLoading: true, errorMessage: ''));
    //   try {
    //     final otp = (100000 + Random().nextInt(900000)).toString();
    //
    //     await authRepository.sendOtpToEmail(event.email, otp); // check here
    //
    //     emit(state.copyWith(
    //       isLoading: false,
    //       step: SignupStep.otp,
    //       email: event.email,
    //       generatedOtp: otp,
    //     ));
    //   } catch (e){
    //     emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    //   }
    // });
    //
    // on<OtpVertified>((event, emit) {
    //   if (event.otpInput == state.generatedOtp) {
    //     emit(state.copyWith(step: SignupStep.details, errorMessage: ''));
    //   } else {
    //     emit(state.copyWith(errorMessage: 'Invalid OTP'));
    //   }
    // });


    on<EmailSubmitted>((event, emit) async {
      emit(SignupLoadingState());
      try {
        await authRepository.sendEmailLink(event.email);
      } catch(e) {
        emit(SignupErrorState(e.toString()));
      }
    });



  on<SignupNavigateToSigninActionEvent>(_onNavigate);

  on<SignupNavigateToOtpActionEvent>(_onNavigate1);
}}

void _onNavigate(SignupNavigateToSigninActionEvent event,
    Emitter<SignupState> emit,) {
  emit(SignupNavigateToSigninActionState());
}

void _onNavigate1(SignupNavigateToOtpActionEvent event,
    Emitter<SignupState> emit,) {
  emit(SignupNavigateToOtpActionState());
}