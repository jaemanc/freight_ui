import 'dart:convert';
import 'dart:io';

import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/domain/dto/paging.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';
import 'package:logger/logger.dart';

abstract class ExpenditureRepository {
  Future<PagingDto<Expenditure>> get({Map<String, dynamic>? queryParameters});
  Future<Expenditure> update(Expenditure expenditure);
  Future<Expenditure> create(ExpenditureDto expenditureDto);
  Future<Expenditure> delete();
  Future<bool> downExcel();
}

class ExpenditureRepositoryImpl extends ExpenditureRepository {
  ExpenditureRepositoryImpl();
  
  var logger = Logger();

  final _freightClient = FreightClient();

  
  @override
  Future<Expenditure> create(ExpenditureDto expenditureDto) async {
    return Future.value(Expenditure.fromDto(expenditureDto));
  }

  @override 
  Future<bool> downExcel() async {
    return true;
  }
  
  @override
  Future<PagingDto<Expenditure>> get( {Map<String, dynamic>? queryParameters}) async {

    try {
      final response =  await _freightClient.get('/api/v1/spend', queryParameters: queryParameters);
      
      final status = response.statusCode;

      PagingDto<Expenditure> result = PagingDto.optional(
            datas: [],
            totalMount: 0,
            totalCount: 0); 
        
      final resultData = jsonDecode(utf8.decode(response.bodyBytes));

      logger.d('response ::  $resultData , parameters :: $queryParameters , response statuscode : $status' );


      final int statusCode = response.statusCode;
  
      if ((statusCode == HttpStatus.ok) || (statusCode == HttpStatus.noContent)) {
          final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(resultData['data']);
          List<Expenditure> expenditureList = data.map((json) => Expenditure.fromJson(json)).toList();
          result.datas = expenditureList;
          result.totalCount = resultData['totalCount'];
          result.totalMount = resultData['totalMount'];
      }

      return result;
    } on Exception catch (e, stackTrace) { 
      logger.e(e);
      logger.e(stackTrace);
      return PagingDto();
    }

  }
  
  @override
  Future<Expenditure> update(Expenditure expenditure) async {
    return Future.value(expenditure);
  }
  
  @override
  Future<Expenditure> delete() async {
    return Future.value(new Expenditure(id: 1, userId: '1', paymentDate: new DateTime(2017,9,7,17,30), price: 10, paymentDetail: '123', extra: '123', delYn: 'N', totalCount: 0, totalMount: 0));
  }

}