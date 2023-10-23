import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/repositories/expenditure_repository.dart';
import 'package:freight_ui/services/expenditure_service.dart';
import 'package:freight_ui/states/expenditure/expenditure_event.dart';
import 'package:freight_ui/states/expenditure/expenditure_state.dart';
import 'package:freight_ui/utills/date.dart';
import 'package:logger/logger.dart';


class ExpenditureBloc extends Bloc<ExpenditureEvent, ExpenditureState> {

  var logger = Logger();

  final expenditureService = ExpenditureService();
  final ExpenditureRepository _expenditureRepository;
  ExpenditureBloc(this._expenditureRepository) : super(ExpenditureState.initial()) {
    on<ExpenditureLoadStarted>(_onLoadStarted);
    on<ExpenditureCreated>(_onCreated);
    on<ExpenditureDeleted>(_onDeleted);
    on<ExpenditureSelectedDateChanged>(_onSelectedDateChanged);
    on<ExpenditurePageChanged>(_onPageChanged);
    on<ExpenditureExcelDownload>(_onExcelDownload);
  }

  void _onLoadStarted(ExpenditureLoadStarted event, Emitter<ExpenditureState> emit) async {
    try {
      emit(state.asLoading());

      var logger = Logger();
      logger.d(' logger test ${state.page}  / ${state.size} / ${state.selectedDate}');

      final data = await _expenditureRepository.get(
        queryParameters: {
          "date": CurrentDate('yyyy-MM-dd',dateTime: state.selectedDate),
          "page" : state.page.toString(),
          "size" : state.size.toString()
        }
      );
      
      emit(state.asLoadSuccess(
        data.datas,
        totalCount: data.totalCount,
         canLoadMore: false,));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }
  
  
  void _onSelectedDateChanged(ExpenditureSelectedDateChanged event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());

      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

  void _onPageChanged(ExpenditurePageChanged event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());

      final data = await _expenditureRepository.get(
        queryParameters: {
          "date": CurrentDate('yyyy-MM-dd',dateTime: state.selectedDate),
          "page" : event.page.toString(),
          "size" : state.size.toString()
        }
      );

      emit(state.asLoadSuccess(data.datas, canLoadMore: false, page: event.page, totalCount: data.totalCount));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

  void _onCreated(ExpenditureCreated event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());

      final ExpenditureDto expenditureDto = event.expenditureDto;
      final expenditure = await _expenditureRepository.create(expenditureDto);
      state.data.insert(0,expenditure);

      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

  void _onUpdated(ExpenditureUpdated event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());

      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

  void _onDeleted(ExpenditureDeleted event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());

      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

  void _onExcelDownload(ExpenditureExcelDownload event, Emitter<ExpenditureState> emit) async {
    try{
      emit(state.asLoading());
      await _expenditureRepository.downExcel();
      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e,stackTrace) {
      logger.e('$e  $stackTrace');
      emit(state.asLoadFailure(e));
    }
  }

}