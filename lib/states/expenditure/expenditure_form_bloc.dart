import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';
import 'package:freight_ui/repositories/expenditure_repository.dart';

class ExpenditureFormBloc extends FormBloc<String, String> {

  final ExpenditureRepository _expenditureRepository;

  final id = TextFieldBloc<int>();
  final paymentDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final paymentDetail = TextFieldBloc<String>();
  final price = TextFieldBloc<int>();
  final userId = TextFieldBloc<String>();
  final extra = TextFieldBloc();

  ExpenditureFormBloc(this._expenditureRepository) :
  super(autoValidate: true) {
    addFieldBlocs(fieldBlocs: [
      id,
      paymentDate,
      paymentDetail,
      price,
      userId,
      extra
    ]);
  }

  void clearValues(){
      id.clear();
      paymentDate.clear();
      paymentDetail.clear();
      price.clear();
      userId.clear();
      extra.clear();
  }

  void setValues(Expenditure? expenditure) {
    if(expenditure == null){
      clearValues();
    }else{
      id.changeValue(expenditure.id.toString());
      paymentDate.changeValue(expenditure.paymentDate);
      paymentDetail.changeValue(expenditure.paymentDetail);
      price.changeValue(expenditure.price.toString());
      userId.changeValue(expenditure.userId);
      extra.changeValue(expenditure.extra);
    }
    
  }

  void addErrors() {
    id.addFieldError('Awesome Error!');
    paymentDate.addFieldError('Awesome Error!');
    paymentDetail.addFieldError('Awesome Error!');
    price.addFieldError('Awesome Error!');
    userId.addFieldError('Awesome Error!');
    extra.addFieldError('Awesome Error!');
  }


  @override
  void onSubmitting() async {
    try {

      emitSuccess(
          successResponse: ExpenditureDto(
              id: id as int,
              paymentDate: paymentDate.value as DateTime,
              paymentDetail: paymentDetail.value,
              price: price.valueToInt as int,
              userId: userId as String,
              extra: extra.value,
              totalCount: 0,
              totalMount: 0,
          ).toJson(),
          canSubmitAgain: true
      );
    } catch (e) {

      emitFailure(failureResponse: e.toString());
    }
  }
}



