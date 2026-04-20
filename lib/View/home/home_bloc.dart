import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeNavigationToCreateNewLedgerEvent>(_onNavigate);

    // TODO: implement event handler
  }

  void _onNavigate(
      HomeNavigationToCreateNewLedgerEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigationToCreateNewLedgerState());
  }
}
