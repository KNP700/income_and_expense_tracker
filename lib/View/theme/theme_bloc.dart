import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';

part 'theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDarkMode: true)) {
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      final isDark = prefs.getBool('isDarkMode') ?? true;
      emit(ThemeState(isDarkMode: isDark));
    });

    on<ToggleThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', event.isDarkMode);
      emit(ThemeState(isDarkMode: event.isDarkMode));
    });
  }
}
