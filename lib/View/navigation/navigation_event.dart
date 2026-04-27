part of 'navigation_bloc.dart';

@immutable
 class NavigationEvent {}


class TabChange extends NavigationEvent{
  final int tabIndex;
  TabChange({required this.tabIndex});
}
