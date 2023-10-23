import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/expenditure/expenditure_bloc.dart';
import 'package:freight_ui/states/expenditure/expenditure_form_bloc.dart';
import 'package:freight_ui/ui/widgets/loader.dart';

class ExpenditureForm extends StatefulWidget {
  final Expenditure? expenditure;
  final bool editable;

  const ExpenditureForm({super.key, this.expenditure, this.editable = false});
  
  @override
  State<StatefulWidget> createState() => _ExpenditureFormState();
}

class _ExpenditureFormState extends State<ExpenditureForm> {
  
  ExpenditureBloc get expenditureBloc => context.read<ExpenditureBloc>();
  ExpenditureFormBloc get formBloc => context.read<ExpenditureFormBloc>();

  Expenditure? get expenditure => widget.expenditure;
  bool get editable => widget.editable;
  late bool edit = editable;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    formBloc.setValues(expenditure);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FormBlocListener<ExpenditureFormBloc, String, String> (
        onSubmitting: (context, state) {
          if(state.isValid()) {
            LoadingDialog.show(context);
          }
        },
        onSuccess: (context, state) {
          LoadingDialog.hide(context);
          AppNavigator.pop();
        },
      )
    );
  }
}
