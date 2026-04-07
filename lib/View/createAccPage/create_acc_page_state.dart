part of 'create_acc_page_bloc.dart';

@immutable
sealed class CreateAccPageState {}

final class CreateAccPageInitial extends CreateAccPageState {}

class ContinueCreateAccToSignInState extends CreateAccPageState{}

class ContinueCreateAccToSignIn2State extends CreateAccPageState{}

class CreateAccLoadingState extends CreateAccPageState{}

class CreateAccSuccessState extends CreateAccPageState{}

class CreateAccErrorState extends CreateAccPageState{
  final String errorMessage;

  CreateAccErrorState(this.errorMessage);
}