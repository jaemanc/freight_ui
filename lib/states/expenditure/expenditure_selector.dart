import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';
import 'package:freight_ui/states/expenditure/expenditure_bloc.dart';
import 'package:freight_ui/states/expenditure/expenditure_state.dart';

class ExpenditureStateSelector<T> extends BlocSelector<ExpenditureBloc, ExpenditureState, T> {
  ExpenditureStateSelector({
    required T Function(ExpenditureState) selector,
    required Widget Function(T) builder,
  }) : super( 
    selector: selector,
    builder: (_, value) => builder(value)
  );
}

class ExpenditureStateStatusSelector extends ExpenditureStateSelector<ExpenditureStateStatus> {
  ExpenditureStateStatusSelector(Widget Function(ExpenditureStateStatus) builder)
  : super(
    selector: (state) => state.status,
    builder: builder
  );
}

class ExpenditureCountSelector extends ExpenditureStateSelector<int> {
  ExpenditureCountSelector(Widget Function(int) builder)
  : super(
    selector: (state) => state.data.length,
    builder: builder
  );
}

class ExpenditureSelector extends ExpenditureStateSelector<ExpenditureSelectorState> {
  ExpenditureSelector(int index, Widget Function(Expenditure, bool) builder)
  : super(
    selector: (state) => ExpenditureSelectorState(
      state.data[index],
      state.selectedIndex == index
    ),
    builder: (value) => builder(value.expenditure, value.selected)
    );
}

class ExpenditureSelectorState {
  final Expenditure expenditure;
  final bool selected;

  const ExpenditureSelectorState(this.expenditure, this.selected);

  @override
  bool operator == (Object other) => 
    other is ExpenditureSelectorState && expenditure == other.expenditure && selected == other.selected;
}

class ExpenditurePageSelector extends ExpenditureStateSelector<ExpenditureSelectorPageState> {
  ExpenditurePageSelector(Widget Function(int, int) builder)
      : super(
      selector: (state) => ExpenditureSelectorPageState(
        state.page,
        state.totalCount~/state.size
      ),
      builder: (value) => builder(value.page, value.totalPage)
  );
}

class ExpenditureSelectorPageState {
  final int page;
  final int totalPage;
  ExpenditureSelectorPageState(this.page, this.totalPage);
}

class ExpenditureTotalCountSelector extends ExpenditureStateSelector<int> {
  ExpenditureTotalCountSelector(Widget Function(int) builder)
    : super(
      selector: (state) => state.totalCount,
      builder: builder
    );
}
