import 'package:bloc/bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'setting_page_event.dart';

part 'setting_page_state.dart';

class SettingPageBloc extends Bloc<SettingPageEvent, SettingPageState> {
  final AuthRepository authRepository;

  SettingPageBloc({required this.authRepository})
      : super(SettingPageInitial()) {
    on<LogoutRequested>((event, emit) async {
      emit(SettingLoading());
      try {
        await authRepository.logOut();
        emit(SettingLogoutSuccess());
      } catch (e) {
        // emit(SettingLogoutFailed(e.toString()));
      }
    });
  }
}
