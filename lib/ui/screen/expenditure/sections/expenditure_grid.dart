part of '../expenditure.dart';

class _ExpenditureGrid extends StatefulWidget {
  const _ExpenditureGrid();

  @override
  State<StatefulWidget> createState() => _ExpenditureGridState();
}

class _ExpenditureGridState extends State<_ExpenditureGrid> {
  PagingDto<Expenditure> pagingDto = PagingDto();

  // final NumberPaginatorController _controller = NumberPaginatorController();
  final expenditureService = ExpenditureService();

  ExpenditureBloc get expenditureBloc => context.read<ExpenditureBloc>();

  @override
  void initState() {
    super.initState();

    expenditureBloc.add(const ExpenditureLoadStarted());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpenditureStateStatusSelector((status) {
            switch(status) {
              case ExpenditureStateStatus.loading:
                print(' expenditure list load... ');
                return const Loader();
              case ExpenditureStateStatus.loadSuccess:
                print(' expenditure list load success ');
                return Column(
                  children: [
                    _buildHeader(),
                    _buildGrid(),
                    _buildFooter(),
                    _buildPagenation(),
                  ],
                );
              default:
                return Container();
            }
          }),
        ]
      ),
    );
  }

  Widget _buildHeader(){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeaderButton(
                    const Icon(Icons.add),
                    () => _onAddPress()
                  ),
                  SizedBox(width: screenWidth * 0.07),
                  SimpleCalendar(),
                  SizedBox(width: screenWidth * 0.07),
                  _buildHeaderButton(
                    const Image(image: AppImages.excel,),
                    (){}
                  )
                ],
              ),
            )
          );
  }

  Widget _buildHeaderButton(Widget icon, VoidCallback callback){
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenHeight * 0.05,
      height: screenHeight * 0.05,
      child: IconButton(
        icon: icon,
        onPressed: callback,
      ),
    );
  }

  void _onAddPress(){
    showDialog (
      context: context, 
      builder: (BuildContext context) {
        return ExpenditureForm();
      }
    );
  }
 
  void _onCardPress(Expenditure expenditure, context){
    showDialog(
      context: context,
      builder: (BuildContext contex) {
        return ExpenditureForm(
          expenditure: expenditure,
          editable:  true,
        );
      }
    );
  }

  Widget _buildGrid(){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.6,
      width: screenWidth * 0.97,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(2),
            sliver: ExpenditureCountSelector((expenditureCount) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 4.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (_, index) {
                              return ExpenditureSelector(index, (expenditure, _) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: ExpenditureCard(
                                    expenditure: expenditure,
                                    onPress: () => _onCardPress(expenditure, context),
                                  )
                                  );
                              });
                            },
                            childCount: expenditureCount
                          )
              );
            }),
          )
        ],
      )
    );
  }

  Widget _buildFooter() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
       return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExpenditureTotalCountSelector((expenditureCount){
            return Container(
              padding: EdgeInsets.only(left: screenHeight * 0.1),
              width:screenWidth * 0.6 ,
              child: Text("총 ${expenditureCount}건"),
            );
          }),
          SizedBox(
            width:screenWidth * 0.3 ,
            child: const TextButton(
                onPressed: AppNavigator.pop,
                child: Text('처음으로')
            ),
          )
        ],
    );
  }

  Widget _buildPagenation() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return ExpenditurePageSelector((currentPage, totalPage) {
      return NumberPaginator (
        numberPages: totalPage +1,
        initialPage: currentPage -1,
        onPageChange: (int index) {
          print("page ${index}");
          expenditureBloc.add(ExpenditurePageChanged(index+1));
        },
      );
    });
  }
}