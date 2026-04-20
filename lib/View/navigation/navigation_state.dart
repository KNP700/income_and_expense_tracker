part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

class TabNavigation {
  final int tabIndex;

  const TabNavigation({required this.tabIndex});
}
