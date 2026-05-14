import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'start_view_event.dart';

part 'start_view_state.dart';

class StartViewBloc extends Bloc<StartViewEvent, StartViewState> {
  final AuthRepository authRepository;


  StartViewBloc({required this.authRepository}) : super(StartViewInitial()) {
    on<CheckAuthStatus>((event, emit) async {
      await Future.delayed(const Duration(seconds: 5));
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated( user: user,token: ''));
      } else {
        emit(AuthUnauthenticated());
      }
    }
    );
    add(CheckAuthStatus());
  }
}