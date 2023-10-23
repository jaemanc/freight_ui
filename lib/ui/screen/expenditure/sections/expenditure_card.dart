
import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';

class ExpenditureCard extends StatelessWidget {
  final Expenditure expenditure;
  final void Function()? onPress;
  const ExpenditureCard ({
    super.key,
    required this.expenditure,
    this.onPress
  });
  
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        const Color color = AppColors.whiteGrey;

        return Container(
          decoration:  BoxDecoration(
            color: color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: onPress,
              splashColor: Colors.white10,
              highlightColor: Colors.white10,
              child: Stack(
                children: [
                  _ExpenditureCard(expenditure: expenditure)
                ],
              )
            ),
          )
          );
      }
      );
      }
}

class _ExpenditureCard extends StatelessWidget {
  final Expenditure expenditure;

  const _ExpenditureCard({
    required this.expenditure
  });

  @override
  Widget build(BuildContext context) {
    // return _buildExpenditureCard(context);
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top:screenHeight * 0.015,
          left: 10,
          right: 10,
        ),
        child: _buildExpenditureRow()
      )
    );
  }

  Widget _buildExpenditureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildDateText(expenditure.paymentDate),
            const Text('/', textAlign: TextAlign.center,),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildDateText(expenditure.paymentDate),
            const Text('/', textAlign: TextAlign.center,),
            const Text(' text test'),
          ],
        ),
        Flexible(
          child: Text(
            expenditure.paymentDetail,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ),
        Text(expenditure.price.toString())
      ],
    );
  }

  Widget _buildDateText(DateTime expenditureProperty) {
    return Text("${expenditureProperty.month.toString()}월 ${expenditureProperty.day.toString()}일");
  }
}