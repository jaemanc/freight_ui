import 'package:flutter/material.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/domain/dto/paging.dart';
import 'package:freight_ui/services/expenditure_service.dart';
import 'package:freight_ui/ui/widgets/form/calendar_year_month.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  /*
    1. 메인 화면 달력 선택 appBar
    2. 달 선택에 따른 검색 초기화.
    3. 검색 리스트 보여주기. body
    4. ios / galaxy 뒤로가기 버튼 막을 것. 
    5. 신규 등록 페이지
    6. 상세 페이지 X ? -> 수정 / 삭제 페이지로 넘어 가기 힘듦.
    7. 수정 - 페이지 - 삭제 버튼 추가.
  */
  PagingDto<ExpenditureDto> pagingDto = PagingDto();
  int itemsPerPage = 10; // 페이지 당 아이템 수
  int currentPage = 1;

  final NumberPaginatorController _controller = NumberPaginatorController();
  final expenditureService = ExpenditureService();
  String targetDate = '2023-09-01';

  @override
  void initState() {
    super.initState();
    // loadExpenditureList();
    loadPagingList(currentPage);
  }

  void changeDate(String date) {
    this.targetDate = date;
  }

  void loadPagingList(int currentPage) async {
    print(' current page : ${currentPage}');
    try {
      var result = await expenditureService.getExpenditureList(currentPage, itemsPerPage, targetDate);
      double _itemsPerpage = (result.totalCount/itemsPerPage);
      itemsPerPage = _itemsPerpage.ceil();
      setState(() {
        pagingDto.datas = result.datas;
        pagingDto.totalCount = result.totalCount;
        pagingDto.totalMount = result.totalMount;
      });

    } catch (e) {
      print("error!!!! : $e" );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('지출 내역'),
          // 햄버거 버튼 추가
          leading: Builder(
            builder: (BuildContext context) {
              return (Text(''));
            },
          ), 
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    print('추가 버튼 눌렀습니다.');
                  }, icon: Icon(Icons.add),),
                  
                  // 달력으로 선택해서 날짜 변경시. 
                  // 요청 날짜도 변경되도록..
                  SimpleCalendar(),
                  InkWell(
                    onTap: () {
                      print(' 엑셀 버튼 눌러씃ㅂ니다');
                    },
                    child: Image.asset('assets/images/excel-24.png'),
                  )
                ],
            ),
            Expanded(
              child: ListView(
              children: pagingDto.datas
                  .map((e) => Card(
                        child: Text(e.paymentDetail),
                      ))
                  .toList(),
              )
            ),
            // Todo 
            // 총 57건 / 총 금액 
            // 처음으로 버튼 
            // 왼쪽 화살표 페이징 오른쪽 화살표
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // 테두리 스타일
                          borderRadius: BorderRadius.circular(10.0), // 박스 모서리 둥글게
                        ),
                    child: Column(
                      children:[
                        Text('총 ${pagingDto.totalCount} 건'),
                        Text('총 ${pagingDto.totalMount} 원 ')
                      ]
                    )
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0), // 버튼 패딩
                    ),
                    onPressed: () {
                      // 아이콘을 클릭했을 때 수행할 동작을 여기에 추가하세요.
                      // 예: 새 항목 추가 또는 다른 기능 수행
                    },
                    child: Text('처음으로'), // 버튼 텍스트
                  ),
                ],
            ),
            //Todo
            //페이징
            NumberPaginator(
              controller: _controller, 
              numberPages: itemsPerPage,
              onPageChange: (int index) {
                setState(() {
                  currentPage = index+1; 
                });
                // 페이지가 변경됐으므로, 리스트도 새로 받아와야 한다.
                loadPagingList(currentPage);
              },
            ),
          ],
        ));
        
  }
  
  
}


