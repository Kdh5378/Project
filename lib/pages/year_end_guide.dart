import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class YearEndGuide extends StatefulWidget {
  const YearEndGuide({Key? key}) : super(key: key);

  @override
  _YearEndState createState() => _YearEndState();
}

class _YearEndState extends State<YearEndGuide> {
  final TextEditingController textController = new TextEditingController();
  var f = NumberFormat('###,###,###,###');
  
  var mySalary        = 60000000;
  var tmpMySalary     = '60,000,000';
  var myCreditAmount  = 4000000;
  var tmpMyCredit     = '4,000,000';
  var usedAmount      = 11000000;
  var exessAmount     = 15000000;
  var tmpExcessAmount = '15,000,000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 231),
      appBar: AppBar(
        title: const Text(
          '연말정산 가이드',
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
              //margin: const EdgeInsets.only(top: 30.0),
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: const Text(
                      '2024년 예상 연봉',
                      style: TextStyle(
                          fontFamily: 'PretendardBold', fontSize: 18.0),
                    ),
                  ),
                  Text('$tmpMySalary 원',
                  style: const TextStyle(
                          fontFamily: 'PretendardExtraBold', fontSize: 30.0),),
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        labelText: '연봉',
                        labelStyle: TextStyle(fontFamily: 'PretendardRegular'),
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 80, 120, 194)), // 동적 border 색상
                              ),
                     ),
                     keyboardType: TextInputType.number,
                     inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                     ],
                  ),
                  const SizedBox(
                    width: 60.0,
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        mySalary        = int.parse(textController.text);
                        tmpMySalary     = f.format(mySalary);
                        exessAmount     = (mySalary*0.25) as int;
                        myCreditAmount  = exessAmount - usedAmount;
                        tmpMyCredit     = f.format(myCreditAmount);
                        tmpExcessAmount = f.format(exessAmount);
                      });
                      debugPrint('조회페이지로 이동');
                    },
                    child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 38, 72, 146),
                          border: Border.all(
                              color: const Color.fromARGB(255, 38, 72, 146),
                              width: 3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          '입력',
                          style: TextStyle(
                              fontFamily: 'PretendardSemiBold',
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              padding: const EdgeInsets.fromLTRB(00.0, 10.0, 20.0, 10.0),
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '앞으로',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 17.0),
                        ),
                        Text(
                          '$tmpMyCredit 원',
                          style: const TextStyle(
                              fontFamily: 'PretendardBold', fontSize: 22.0),
                        ),
                        const Text(
                          '신용카드 사용',
                          style: TextStyle(
                              fontFamily: 'PretendardBold',
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 80, 120, 194)),
                        ),
                        const Text(
                          '을 추천해요',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 17.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              padding: const EdgeInsets.fromLTRB(00.0, 10.0, 20.0, 10.0),
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '결제금액',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 17.0),
                        ),
                        Text(
                          '$tmpExcessAmount 원',
                          style: const TextStyle(
                              fontFamily: 'PretendardBold', fontSize: 20.0),
                        ),
                        const Text(
                          '초과부터 카드소득공제를 받을 수 있어요',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 17.0),
                        ),
                        const Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 13.0),
                        ),
                        const Text(
                          '※ 연소득의 25%까지는 혜택이 높은 신용카드 사용을 추천합니다.',
                          style: TextStyle(
                              fontFamily: 'PretendardRegular', fontSize: 13.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
