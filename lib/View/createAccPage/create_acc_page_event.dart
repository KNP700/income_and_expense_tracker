part of 'create_acc_page_bloc.dart';

@immutable
sealed class CreateAccPageEvent {}

class ContinueCreateAccToSignInEvent extends CreateAccPageEvent{}

class ContinueCreateAccToSignIn2Event extends CreateAccPageEvent{}


