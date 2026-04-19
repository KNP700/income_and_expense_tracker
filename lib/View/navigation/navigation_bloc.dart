import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, TabNavigation> {
  NavigationBloc() : super(const TabNavigation(tabIndex: 0)) {
    on<TabChange>((event, emit) {
      emit(TabNavigation(tabIndex: event.tabIndex));
      // TODO: implement event handler
    });
  }
}
