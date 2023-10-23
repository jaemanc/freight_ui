import 'package:freight_ui/domain/dto/expenditure.dart';

abstract class ExpenditureEvent {
  const ExpenditureEvent();
}

class ExpenditureLoadStarted extends ExpenditureEvent {
  final bool loadAll;
  const ExpenditureLoadStarted({this.loadAll = false});
}

class ExpenditureCreated extends ExpenditureEvent {
  final ExpenditureDto expenditureDto;
  const ExpenditureCreated(this.expenditureDto);
}

class ExpenditureUpdated extends ExpenditureEvent {
  final ExpenditureDto expenditureDto;
  final int id;
  const ExpenditureUpdated(this.id, this.expenditureDto);
}

class ExpenditureDeleted extends ExpenditureEvent {
  final int id;
  const ExpenditureDeleted(this.id);
}

class ExpenditureSelectedDateChanged extends ExpenditureEvent {
  final DateTime selectedDate;
  ExpenditureSelectedDateChanged(this.selectedDate);
}

class ExpenditurePageChanged extends ExpenditureEvent {
  final int page;
  ExpenditurePageChanged(this.page);
}

class ExpenditureExcelDownload extends ExpenditureEvent {
  const ExpenditureExcelDownload();
}

