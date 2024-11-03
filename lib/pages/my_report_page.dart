import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({Key? key}) : super(key: key);

  @override
  _MyReportPage createState() => _MyReportPage();
}

var f = NumberFormat('###,###,###,###');

class _MyReportPage extends State<MyReportPage> {
  final TextEditingController textController = TextEditingController();

 num savedMoney = 16002;
 String tmpSavedMoney = '16,002';
 num    maxMoney = 16977;
 String tmpMaxMoney = '16,977';
 num    myPercent = 94;
 num    maxSavedMoney = 975;
 String tmpMaxSavedMoney = '975';

  int selectedYear = 2024;
  int selectedMonth = 10;

  List<Map<String, dynamic>> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    // 초기 결제 내역 설정
    filterPayments();
  }

  void filterPayments() {
    // 선택된 연도와 월에 따라 결제 내역을 필터링하고 변수 값을 변경
    setState(() {
      if (selectedMonth == 10) {
        savedMoney = 16002;
        tmpSavedMoney = '16,002';
        maxMoney = 16977;
        tmpMaxMoney = '16,977';
        myPercent = 94;
        maxSavedMoney = 975;
        tmpMaxSavedMoney = '975';

        paymentHistory = [
          {
            'storeName': '안양농협',
            'paymentDate': '2024-10-01',
            'paymentAmount': 60950,
            'usedCard': '채움패밀리카드Ⅱ',
            'discountFromUsedCard': 3047,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 3047,
          },
          {
            'storeName': '스타벅스커피코리아',
            'paymentDate': '2024-10-01',
            'paymentAmount': 12800,
            'usedCard': '채움패밀리카드Ⅱ',
            'discountFromUsedCard': 5000,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 5000,
          },
          {
            'storeName': '네이버파이낸셜',
            'paymentDate': '2024-10-02',
            'paymentAmount': 120000,
            'usedCard': '네이버 현대카드',
            'discountFromUsedCard': 6000,
            'recommendedCard': '네이버 현대카드',
            'discountFromRecommendedCard': 6000,
          },
          {
            'storeName': '경기인천버스(대표)',
            'paymentDate': '2024-10-04',
            'paymentAmount': 4250,
            'usedCard': 'NH1934 체크카드',
            'discountFromUsedCard': 120,
            'recommendedCard': 'K-패스카드(채움)',
            'discountFromRecommendedCard': 230,
          },
          {
            'storeName': '농협중앙회신용협동조합아리샵',
            'paymentDate': '2024-10-11',
            'paymentAmount': 60000,
            'usedCard': '채움패밀리카드Ⅱ',
            'discountFromUsedCard': 1800,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 1800,
          },
          {
            'storeName': '롯데리아포일IT점',
            'paymentDate': '2024-10-15',
            'paymentAmount': 10200,
            'usedCard': 'NH1934 체크카드',
            'discountFromUsedCard': 20,
            'recommendedCard': '네이버 현대카드',
            'discountFromRecommendedCard': 180,
          },
          {
            'storeName': '이로운이비인후과',
            'paymentDate': '2024-10-15',
            'paymentAmount': 9700,
            'usedCard': 'K-패스카드(채움)',
            'discountFromUsedCard': 0,
            'recommendedCard': '네이버 현대카드',
            'discountFromRecommendedCard': 485,
          },
          {
            'storeName': '예손약국',
            'paymentDate': '2024-10-15',
            'paymentAmount': 4300,
            'usedCard': 'K-패스카드(채움)',
            'discountFromUsedCard': 0,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 215,
          },
          {
            'storeName': '뚜레쥬르포일점',
            'paymentDate': '2024-10-18',
            'paymentAmount': 4200,
            'usedCard': 'NH1934 체크카드',
            'discountFromUsedCard': 15,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 20,
          },
        ];
      } else if (selectedMonth == 11) {
        savedMoney = 337;
        tmpSavedMoney = '1,337';
        maxMoney = 5523;
        tmpMaxMoney = '5,523';
        myPercent = 24;
        maxSavedMoney = 4186;
        tmpMaxSavedMoney = '4,186';
        paymentHistory = [
          {
            'storeName': 'CGV평촌',
            'paymentDate': '2024-11-02',
            'paymentAmount': 30000,
            'usedCard': 'K-패스카드(채움)',
            'discountFromUsedCard': 0,
            'recommendedCard': '채움패밀리카드Ⅱ',
            'discountFromRecommendedCard': 5000,
          },
          {
            'storeName': 'CU인덕원점',
            'paymentDate': '2024-11-02',
            'paymentAmount': 7200,
            'usedCard': 'K-패스카드(채움)',
            'discountFromUsedCard': 300,
            'recommendedCard': 'NH1934 체크카드',
            'discountFromRecommendedCard': 400,
          },
          {
            'storeName': '세븐일레븐서초사당점',
            'paymentDate': '2024-11-03',
            'paymentAmount': 12300,
            'usedCard': '채움패밀리카드Ⅱ',
            'discountFromUsedCard':37,
            'recommendedCard': '네이버 현대카드',
            'discountFromRecommendedCard': 123,
          },
        ];
      }
      // 필요한 추가 월에 대한 더미 데이터 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '분석리포트',
          style: TextStyle(fontFamily: 'PretendardLight'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildYearMonthSelector(),
            _buildSavingsDisplay(),
            _buildUsageSummary(),
            _savingsComparison(),
            _buildPaymentHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildYearMonthSelector() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                if (selectedMonth > 1) {
                  selectedMonth--;
                } else {
                  selectedMonth = 12;
                  selectedYear--;
                }
                filterPayments(); // 월이 변경될 때 필터링
              });
            },
          ),
          const SizedBox(width: 10),
          Text('$selectedMonth월', style: const TextStyle(fontFamily: 'PretendardBold', fontSize: 25.0)),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                if (selectedMonth < 12) {
                  selectedMonth++;
                } else {
                  selectedMonth = 1;
                  selectedYear++;
                }
                filterPayments(); // 월이 변경될 때 필터링
              });
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildSavingsDisplay() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('카드 혜택으로', style: TextStyle(fontFamily: 'PretendardRegular', fontSize: 17.0)),
          Text('$tmpSavedMoney 원', style: const TextStyle(fontFamily: 'PretendardBold', fontSize: 22.0)),
          const Text('절약했어요', style: TextStyle(fontFamily: 'PretendardRegular', fontSize: 17.0)),
        ],
      ),
    );
  }

  Widget _buildUsageSummary() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
        padding: const EdgeInsets.all(20.0),
        width: 205,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: getCorrectColor(myPercent),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Icon(
                myPercent >= 80 ? Icons.sunny : Icons.cloudy_snowing,
                color: myPercent >= 80 ? const Color.fromARGB(255, 243, 206, 43) : const Color.fromARGB(255, 59, 58, 58),
                size: 100,
              ),
            ),
            const SizedBox(height: 15),
            Text('$myPercent % 이상 카드혜택을', style: const TextStyle(fontFamily: 'PretendardRegular', fontSize: 17.0, color: Colors.white)),
            const Text('활용했어요', style: TextStyle(fontFamily: 'PretendardRegular', fontSize: 17.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _savingsComparison() {
  return Container(
    margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0), // 오른쪽 여백 추가
    padding: const EdgeInsets.all(20.0),
    width: double.infinity, // 가로를 가능한 최대 너비로 설정
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 공간을 균등하게 배분
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    '카드 혜택으로\n절약한 금액',
                    style: TextStyle(
                        fontFamily: 'PretendardRegular', fontSize: 17.0),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$tmpSavedMoney 원',
                    style: const TextStyle(
                        fontFamily: 'PretendardBold', fontSize: 20.0),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20), // 간격 추가
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '최대 절약\n가능한 금액',
                    style: TextStyle(
                        fontFamily: 'PretendardRegular', fontSize: 17.0),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$tmpMaxMoney 원',
                    style: const TextStyle(
                        fontFamily: 'PretendardBold', fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 60), // 상단 여백 추가
        const Text(
          '이 카드로 결제했다면',
          style: TextStyle(
              fontFamily: 'PretendardRegular', fontSize: 17.0),
        ),
        Text(
          '$tmpMaxSavedMoney 원',
          style: const TextStyle(
              fontFamily: 'PretendardBold', fontSize: 22.0),
        ),
        const Text(
          '아낄 수 있었어요',
          style: TextStyle(
              fontFamily: 'PretendardRegular', fontSize: 17.0),
        ),
      ],
    ),
  );
}

 Widget _buildPaymentHistory() {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      margin: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
      padding: const EdgeInsets.all(10.0),
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('카드 결제 내역', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 20.0)),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('상세 내역', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                  ],
                ),
              ),
              Expanded(
                flex: 1, // Flex 비율을 조정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('사용 카드', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                    Text('받은 할인', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                  ],
                ),
              ),
              Expanded(
                flex: 1, // Flex 비율을 조정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('추천 카드', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                    Text('최대 할인', style: TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                final payment = paymentHistory[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(payment['storeName'], style: const TextStyle(fontFamily: 'PretendardRegular')),
                            Text(payment['paymentDate'], style: const TextStyle(fontFamily: 'PretendardLight')),
                            Text('${getNumToStr(payment['paymentAmount'])} 원', style: const TextStyle(fontFamily: 'PretendardBold', fontSize: 16.0)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1, // Flex 비율을 조정
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(payment['usedCard'], style: const TextStyle(fontFamily: 'PretendardRegular')),
                            Text('${getNumToStr(payment['discountFromUsedCard'])} 원', style: const TextStyle(fontFamily: 'PretendardRegular')),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1, // Flex 비율을 조정
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(payment['recommendedCard'], style: const TextStyle(fontFamily: 'PretendardRegular')),
                            Text('${getNumToStr(payment['discountFromRecommendedCard'])} 원', style: const TextStyle(fontFamily: 'PretendardRegular')),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}


  Color getCorrectColor(num percent) {
    if (percent >= 80) {
      return const Color.fromARGB(255, 124, 170, 255);
    } else {
      return const Color.fromARGB(255, 161, 157, 157);
    }
  }

  String getNumToStr(num number) {
    return f.format(number);
  }
}