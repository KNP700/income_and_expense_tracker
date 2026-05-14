part of 'start_view_bloc.dart';

@immutable
sealed class StartViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class StartViewInitial extends StartViewState {}

class AuthAuthenticated extends StartViewState{

  final User user;

  final String token;

  AuthAuthenticated({required this.user, required this.token});

  @override
  List<Object> get  props => [user,token];
}



class AuthUnauthenticated extends StartViewState{

  @override
  List<Object> get props => [];
}