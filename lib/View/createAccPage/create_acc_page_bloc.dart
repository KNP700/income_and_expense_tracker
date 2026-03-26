import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_acc_page_event.dart';
part 'create_acc_page_state.dart';

class CreateAccPageBloc extends Bloc<CreateAccPageEvent, CreateAccPageState> {
  CreateAccPageBloc() : super(CreateAccPageInitial()) {
    on<CreateAccPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
