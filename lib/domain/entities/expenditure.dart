import 'package:freight_ui/domain/dto/expenditure.dart';

class Expenditure {
  final int id;
  final String userId;
  final DateTime paymentDate;
  final int price;
  final String paymentDetail;
  final String extra;
  //final DateTime createdAt;
  final String delYn;
  final int totalCount;
  final int totalMount;

  const Expenditure({
    required this.id,
    required this.userId,
    required this.paymentDate,
    required this.price,
    required this.paymentDetail,
    required this.extra,
    // required this.createdAt,
    required this.delYn,
    required this.totalCount,
    required this.totalMount,
  });

  factory Expenditure.fromDto(ExpenditureDto expenditureDto){
      return Expenditure(
        id: expenditureDto.id,
        userId: expenditureDto.userId.toString(),
        paymentDate: expenditureDto.paymentDate,
        price: expenditureDto.price, 
        paymentDetail: expenditureDto.paymentDetail, 
        extra: expenditureDto.extra, 
        // createdAt: expenditureDto.createdAt, 
        delYn: expenditureDto.delYn,
        totalCount: expenditureDto.totalCount,
        totalMount: expenditureDto.totalMount
      );
  }

  factory Expenditure.fromJson(Map<String, dynamic> json) {
    return Expenditure(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
      paymentDate: DateTime.parse(json['paymentDate']),
      price: json['price'] as int? ?? 0,
      paymentDetail: json['paymentDetail'] as String? ?? '',
      extra: json['extra'] as String? ?? '',
      delYn: json['delYn'] as String? ?? '', 
      totalCount: json['totalCount'] as int? ?? 0,
      totalMount: json['totalMount'] as int? ?? 0,
    );
  }


}