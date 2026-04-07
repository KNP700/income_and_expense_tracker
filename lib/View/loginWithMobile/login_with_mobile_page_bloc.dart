import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_with_mobile_page_event.dart';

part 'login_with_mobile_page_state.dart';

class LoginWithMobilePageBloc
    extends Bloc<LoginWithMobilePageEvent, LoginWithMobilePageState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginWithMobilePageBloc() : super(LoginWithMobilePageInitial()) {
    on<MobilePageToOtpEvent>((event, emit) {
      emit(MobilePageToOtpState(verificationId: ""));
    });

    on<PhoneNumberEntered>((event, emit) async {
      emit(MobilePageLoadingState());

      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            emit(MobilePageErrorState(e.message ?? "Verification Failed"));
          },
          codeSent: (String verificationId, int? resendToken) {
            emit(MobilePageToOtpState(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        emit(MobilePageErrorState(e.toString()));
      }
    });
  }
}
