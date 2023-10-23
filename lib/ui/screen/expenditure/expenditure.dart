import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/domain/dto/paging.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/services/expenditure_service.dart';
import 'package:freight_ui/states/expenditure/expenditure_bloc.dart';
import 'package:freight_ui/states/expenditure/expenditure_event.dart';
import 'package:freight_ui/states/expenditure/expenditure_selector.dart';
import 'package:freight_ui/states/expenditure/expenditure_state.dart';
import 'package:freight_ui/ui/screen/expenditure/sections/expenditure_card.dart';
import 'package:freight_ui/ui/screen/expenditure/sections/expenditure_form.dart';
import 'package:freight_ui/ui/widgets/form/calendar_year_month.dart';
import 'package:freight_ui/ui/widgets/loader.dart';
import 'package:logger/logger.dart';
import 'package:number_paginator/number_paginator.dart';

part './sections/expenditure_grid.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  State<StatefulWidget> createState() => ExpenditureScreenState();
}

class ExpenditureScreenState extends State<ExpenditureScreen> { 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Stack(
          fit: StackFit.expand, 
          children: [
            _ExpenditureGrid(),
          ],
        ),
    );
  }
}