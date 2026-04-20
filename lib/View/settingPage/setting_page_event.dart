part of 'setting_page_bloc.dart';

@immutable
sealed class SettingPageEvent {}

class LogoutRequested extends SettingPageEvent{}
