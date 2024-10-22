import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({Key? key}) : super(key: key);

  @override
  _MyReportPage createState() => _MyReportPage();
}

class _MyReportPage extends State<MyReportPage> {
  final TextEditingController textController = new TextEditingController();
  var f = NumberFormat('###,###,###,###');

  num    savedMoney       = 1000000;
  String tmpSavedMoney    = '1,000,000';
  num    maxMoney         = 1200000;
  String tmpMaxMoney      = '1,200,000';
  num    myPercent        = 85;
  num    maxSavedMoney    = 200000;
  String tmpMaxSavedMoney = '200,000';

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
                    children: <Widget>[
                      const Text(
                        '카드 혜택으로\n절약한 금액',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
                      Text(
                        '$tmpSavedMoney 원',
                        style: const TextStyle(
                            fontFamily: 'PretendardBold', fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        '최대절약\n가능한 금액',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '카드내역1',
                      style: TextStyle(
                          fontFamily: 'PretendardRegular', fontSize: 17.0),
                    ),
                    const Text(
                      '카드내역2',
                      style: TextStyle(
                          fontFamily: 'PretendardRegular', fontSize: 17.0),
                    ),
                    const Text(
                      '카드내역3',
                      style: TextStyle(
                          fontFamily: 'PretendardRegular', fontSize: 17.0),
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
