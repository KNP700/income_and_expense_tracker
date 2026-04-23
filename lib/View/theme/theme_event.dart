part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}


class ToggleThemeEvent extends ThemeEvent {
  final bool isDarkMode;
  ToggleThemeEvent({required this.isDarkMode});
}

class LoadThemeEvent extends ThemeEvent {}
