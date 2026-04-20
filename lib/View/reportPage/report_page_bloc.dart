import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'report_page_event.dart';
part 'report_page_state.dart';

class ReportPageBloc extends Bloc<ReportPageEvent, ReportPageState> {
  ReportPageBloc() : super(ReportPageInitial()) {
    on<ReportPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
