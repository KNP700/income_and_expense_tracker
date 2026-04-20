part of 'setting_page_bloc.dart';

@immutable
sealed class SettingPageState {}

final class SettingPageInitial extends SettingPageState {}

class SettingLoading extends SettingPageState{}

class SettingLogoutSuccess extends SettingPageState{}

class SettingLogoutFailed extends SettingPageState{

}


