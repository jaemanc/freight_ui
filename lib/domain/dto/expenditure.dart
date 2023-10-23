import 'dart:convert';

import 'package:freight_ui/utills/date.dart';

class ExpenditureDto {
  final int id;
  final String userId;
  final DateTime paymentDate;
  final int price;
  final String paymentDetail;
  final String extra;
  // final DateTime createdAt;
  final String delYn;
  final int totalCount;
  final int totalMount;

  const ExpenditureDto({
    required this.id,
    required this.userId,
    required this.paymentDate,
    required this.price,
    required this.paymentDetail,
    required this.extra,
    // DateTime? createdAt,
    this.delYn = 'N',
    required this.totalCount,
    required this.totalMount,
  });

  factory ExpenditureDto.fromJson(Map<String, dynamic> json) {
    return ExpenditureDto(
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

  String toJson({bool encode = true}) {
      final Map<String, dynamic> data = {
      'id':id,
      'userId': userId,
      'paymentDate': CurrentDate("yyyy-MM-dd",dateTime: paymentDate),
      'price': price,
      'paymentDetail':paymentDetail,
      'extra': extra,
      'totalCount': totalCount,
      'totalMount': totalMount
    };
    
    return jsonEncode(data);
  }

}