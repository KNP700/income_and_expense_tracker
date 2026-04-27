part of 'create_acc_page_bloc.dart';

@immutable
 class CreateAccPageEvent {}

class ContinueCreateAccToSignInEvent extends CreateAccPageEvent {}

class ContinueCreateAccToSignIn2Event extends CreateAccPageEvent {}

class CreateAccDetailsSubmitted extends CreateAccPageEvent {
  final String firstName, lastName, username, password;

  CreateAccDetailsSubmitted({
      required this.firstName, required this.lastName, required this.username, required this.password});
}


