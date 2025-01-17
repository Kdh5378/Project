import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var f = NumberFormat('###,###,###,###');

num totalPoint      = 0;
num pointLeft       = 0;
num pointUsed       = 0;
num totalRevenue4   = 0;
num pointUsed4      = 0;
num pointOver4      = 0;
num requiredAmount4 = 0;
num deficitAmount4  = 0;

String totalPointText     = '';
String pointLeftText      = '';
String pointUsedText      = '';
String totalRevenue4Text  = '';
String pointUsed4Text     = '';
String pointOver4Text     = '';
String deficitAmount4Text = '';

class WelFarePoint extends StatefulWidget {
  const WelFarePoint({super.key});

  @override
  _WelFarePointState createState() => _WelFarePointState();
}



class _WelFarePointState extends State<WelFarePoint>  {
  List<Map<String, dynamic>> history = [];
  bool isHistoryVisible = false;

  @override
  void initState() {
    super.initState();
    // 더미 데이터를 초기화합니다.
    history = [
      {'date': '2024-10-01', 'amount': 1000000, 'businessName': '카페 A'},
      {'date': '2024-10-05', 'amount': 500000, 'businessName': '식당 B'},
      {'date': '2024-10-10', 'amount': 700000, 'businessName': '마트 C'},
    ];
  }

  void _toggleHistoryVisibility() {
    setState(() {
      isHistoryVisible = !isHistoryVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    setPointText();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 231),
      appBar: AppBar(
        title: const Text(
          '복지포인트 잔액',
          style: TextStyle(fontFamily: 'PretendardLight'),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 231, 231),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '잔여포인트 : $pointLeftText',
                    style:
                        const TextStyle(fontFamily: 'PretendardBold', fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                      height: 13.0,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 212, 208, 208),
                      ),
                    ),
                    Container(
                      height: 13.0,
                      width: MediaQuery.of(context).size.width * 0.6 * pointUsed / totalPoint,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 80, 120, 194),
                      ),
                    ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: 70.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 80, 120, 194),
                        ),
                      ),
                      Text('사용포인트             $pointUsedText',
                          style: const TextStyle(fontFamily: 'PretendardBold')),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 70.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 212, 208, 208),
                        ),
                      ),
                      Text('총 배정포인트        $totalPointText',
                          style: const TextStyle(fontFamily: 'PretendardBold')),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: 330.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                          color: const Color.fromARGB(255, 38, 72, 146),
                          width: 3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '분기 실적 충족 여부 : ',
                          style: TextStyle(
                              fontFamily: 'PretendardSemiBold', fontSize: 15.0),
                        ),
                        if(deficitAmount4 > 0)
                        Text(
                          '$deficitAmount4Text 원',
                          style: const TextStyle(
                              fontFamily: 'PretendardExtraBold',
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 194, 40, 40)),
                        ),
                        if(deficitAmount4 > 0)
                        const Text(
                          ' 부족',
                          style: TextStyle(
                              fontFamily: 'PretendardSemiBold', fontSize: 15.0),
                        ),
                        if(deficitAmount4 <= 0)
                        const Text(
                          '충족',
                          style: TextStyle(
                              fontFamily: 'PretendardExtraBold', fontSize: 15.0),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 171, 190, 226)),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        '2024년 4분기',
                        style: TextStyle(
                            fontFamily: 'PretendardSemiBold', fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 13.0,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(255, 212, 208, 208),
                              ),
                              ),
                           Container(
                            height: 13.0,
                            width: MediaQuery.of(context).size.width * 0.6 * pointOver4 / totalRevenue4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(255, 80, 120, 194),
                              ),
                            )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: 70.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 212, 208, 208),
                            ),
                          ),
                          Text(
                              '총 매출액(A)                            $totalRevenue4Text 원',
                              style: const TextStyle(fontFamily: 'PretendardRegular')),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                              //height: 50.0,
                              ),
                          Container(
                            width: 70.0,
                            height: 10.0,
                          ),
                          Text('포인트 사용 금액(B)                 $pointUsed4Text 원',
                              style: const TextStyle(fontFamily: 'PretendardRegular')),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: 70.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 80, 120, 194),
                            ),
                          ),
                          Text('분기 실적 충족 금액(A-B)         $pointOver4Text 원',
                              style: const TextStyle(fontFamily: 'PretendardBold')),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: _toggleHistoryVisibility,
                  child: Container(
                      width: 330.0,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 38, 72, 146),
                        border: Border.all(
                            color: const Color.fromARGB(255, 38, 72, 146),
                            width: 3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        '복지포인트 사용내역 조회',
                        style: TextStyle(
                            fontFamily: 'PretendardSemiBold',
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        textAlign: TextAlign.center,
                      )),
                ),
                // 사용 내역 목록 표시
              // 사용 내역 목록 표시
              if (isHistoryVisible)
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[index];
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['businessName'],
                                      style: const TextStyle(
                                          fontFamily: 'PretendardBold',
                                          fontSize: 14.0),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      item['date'],
                                      style: const TextStyle(
                                          fontFamily: 'PretendardRegular',
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${getNumToStr(item['amount'])} 원',
                                  style: const TextStyle(
                                      fontFamily: 'PretendardBold',
                                      fontSize: 14.0),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          if (index < history.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(color: Color.fromARGB(255, 200, 200, 200)), // 연한 회색 선
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

String getNumToStr(num tmpNum){
  return f.format(tmpNum);
}

void setPointText(){
  totalPoint      = 4800000;
  pointUsed       = 3400000;
  pointLeft       = totalPoint - pointUsed;
  totalRevenue4   = 1400000;
  pointUsed4      = 1200000;
  pointOver4      = totalRevenue4 - pointUsed4;
  requiredAmount4 = 700000;
  deficitAmount4  = requiredAmount4 - pointOver4;

  totalPointText     = getNumToStr(totalPoint);
  pointUsedText      = getNumToStr(pointUsed);
  pointLeftText      = getNumToStr(pointLeft);
  totalRevenue4Text  = getNumToStr(totalRevenue4);
  pointUsed4Text     = getNumToStr(pointUsed4);
  pointOver4Text     = getNumToStr(pointOver4);
  deficitAmount4Text = getNumToStr(deficitAmount4);
}