import 'package:freight_ui/domain/entities/expenditure.dart';

enum ExpenditureStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure
}

class ExpenditureState {
  final ExpenditureStateStatus status;
  final List<Expenditure> data;
  final int selectedIndex;
  final int page;
  final int size;
  final int totalCount;
  final bool canLoadMore;
  final Exception? error;
  final DateTime selectedDate;


  const ExpenditureState._({
    this.status = ExpenditureStateStatus.initial,
    this.data = const [],
    this.selectedIndex = 0,
    required this.selectedDate,
    this.page = 1,
    this.size = 10,
    this.totalCount = 0,
    this.canLoadMore = true,
    this.error
    
  });

  ExpenditureState.initial() : this._(
    selectedDate:  DateTime.now()
  );

   ExpenditureState asLoading(){
    return copyWith(
      status: ExpenditureStateStatus.loading
    );
  }

  ExpenditureState asLoadSuccess(List<Expenditure> data, {bool canLoadMore = true, int? totalCount, int? page} ) {
    return copyWith(
      status: ExpenditureStateStatus.loadSuccess,
      data: data,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      canLoadMore: canLoadMore
    );
  }

  ExpenditureState asLoadFailure(Exception e){
    return copyWith(
      status: ExpenditureStateStatus.loadFailure,
      error: e
    );
  }

  ExpenditureState copyWith({
    ExpenditureStateStatus? status,
    List<Expenditure>? data,
    int? selectedIndex,
    DateTime? selectedDate,
    int? page,
    int? size,
    int? totalCount,
    bool? canLoadMore,
    Exception? error
  }) {
    return ExpenditureState._(
        status: status ?? this.status,
        data: data ?? this.data,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        page: page ?? this.page,
        size: size ?? this.size,
        totalCount: totalCount ?? this.totalCount,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        error: error ?? this.error
    );
  }
}

