import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({Key? key}) : super(key: key);

  @override
  _MyReportPage createState() => _MyReportPage();
}

var f = NumberFormat('###,###,###,###');

class _MyReportPage extends State<MyReportPage> {
  final TextEditingController textController = new TextEditingController();

  num savedMoney = 1000000;
  String tmpSavedMoney = '1,000,000';
  num maxMoney = 1200000;
  String tmpMaxMoney = '1,200,000';
  num myPercent = 85;
  num maxSavedMoney = 200000;
  String tmpMaxSavedMoney = '200,000';

  List<Map<String, dynamic>> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    // 더미 데이터 초기화
    paymentHistory = [
      {
        'storeName': '카페 A',
        'paymentDate': '2024-10-01',
        'paymentAmount': 1000000,
        'usedCard': '신용카드 1',
        'discountFromUsedCard': 50000,
        'recommendedCard': '신용카드 2',
        'discountFromRecommendedCard': 30000,
      },
      {
        'storeName': '식당 B',
        'paymentDate': '2024-10-05',
        'paymentAmount': 500000,
        'usedCard': '신용카드 3',
        'discountFromUsedCard': 20000,
        'recommendedCard': '신용카드 4',
        'discountFromRecommendedCard': 10000,
      },
      {
        'storeName': '식당 C',
        'paymentDate': '2024-10-05',
        'paymentAmount': 500000,
        'usedCard': '신용카드 3',
        'discountFromUsedCard': 20000,
        'recommendedCard': '신용카드 4',
        'discountFromRecommendedCard': 10000,
      },
      {
        'storeName': '식당 D',
        'paymentDate': '2024-10-05',
        'paymentAmount': 500000,
        'usedCard': '신용카드 3',
        'discountFromUsedCard': 20000,
        'recommendedCard': '신용카드 4',
        'discountFromRecommendedCard': 10000,
      },
      {
        'storeName': '식당 E',
        'paymentDate': '2024-10-05',
        'paymentAmount': 500000,
        'usedCard': '신용카드 3',
        'discountFromUsedCard': 20000,
        'recommendedCard': '신용카드 4',
        'discountFromRecommendedCard': 10000,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          '분석리포트',
          style: TextStyle(fontFamily: 'PretendardLight'),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(00.0, 20.0, 150.0, 10.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '카드 혜택으로',
                            style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 17.0),
                          ),
                          Text(
                            '$tmpSavedMoney 원',
                            style: const TextStyle(
                                fontFamily: 'PretendardBold', fontSize: 22.0),
                          ),
                          const Text(
                            '절약했어요',
                            style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 17.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                width: 205,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: getCorrectColor(myPercent)),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (myPercent >= 80)
                            const Center(
                              child: Icon(
                                Icons.sunny,
                                color: Color.fromARGB(255, 243, 206, 43),
                                size: 100,
                              ),
                            )
                          else
                            const Center(
                              child: Icon(
                                Icons.cloudy_snowing,
                                color: Color.fromARGB(255, 59, 58, 58),
                                size: 100,
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                            width: 50,
                          ),
                          Text(
                            '$myPercent % 이상 카드혜택을',
                            style: const TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 17.0,
                                color: Colors.white),
                          ),
                          const Text(
                            '활용했어요',
                            style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 17.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '카드 혜택으로\n절약한 금액',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$tmpSavedMoney 원',
                        style: const TextStyle(
                            fontFamily: 'PretendardBold', fontSize: 22.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
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
                            fontFamily: 'PretendardBold', fontSize: 22.0),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
              ),
            ),
            // 결제 내역 표시
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '카드 결제 내역',
                      style: TextStyle(
                          fontFamily: 'PretendardBold', fontSize: 20.0),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('상세 내역',
                                  style: TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('사용 카드',
                                  style: TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 16.0)),
                              Text('받은 할인',
                                  style: TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('추천 카드',
                                  style: TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 16.0)),
                              Text('최대 할인',
                                  style: TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 카드 결제 내역 리스트
                    Container(
                      /*
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // 연한 회색 배경
                        //borderRadius: BorderRadius.circular(10.0), // 둥근 모서리
                        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)), // 테두리 추가
                      ),
                      */
                      child: SizedBox(
                        height: 200,
                        child: ListView.separated(
                          itemCount: paymentHistory.length,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.grey),
                          itemBuilder: (context, index) {
                            final item = paymentHistory[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item['storeName'],
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'PretendardRegular',
                                                    fontSize: 16.0)),
                                            Text(
                                                '${getNumToStr(item['paymentAmount'])} 원',
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'PretendardRegular',
                                                    fontSize: 16.0)),
                                          ],
                                        ),
                                        Text(item['paymentDate'],
                                            style: const TextStyle(
                                                fontFamily: 'PretendardRegular',
                                                fontSize: 14.0)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('${item['usedCard']}',
                                            style: const TextStyle(
                                                fontFamily: 'PretendardRegular',
                                                fontSize: 14.0)),
                                        Text(
                                            '${getNumToStr(item['discountFromUsedCard'])} 원',
                                            style: const TextStyle(
                                                fontFamily: 'PretendardRegular',
                                                fontSize: 14.0)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('${item['recommendedCard']}',
                                            style: const TextStyle(
                                                fontFamily: 'PretendardRegular',
                                                fontSize: 14.0)),
                                        Text(
                                            '${getNumToStr(item['discountFromRecommendedCard'])} 원',
                                            style: const TextStyle(
                                                fontFamily: 'PretendardRegular',
                                                fontSize: 14.0)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getCorrectColor(num tmpNum) {
    if (tmpNum >= 80) {
      return const Color.fromARGB(255, 124, 170, 255);
    } else {
      return const Color.fromARGB(255, 161, 157, 157);
    }
  }
}

String getNumToStr(num tmpNum) {
  return f.format(tmpNum);
}
