import 'package:flutter/material.dart';

class YearEndGuide extends StatefulWidget {
  const YearEndGuide({Key? key}) : super(key: key);

  @override
  _YearEndState createState() => _YearEndState();
}

class _YearEndState extends State<YearEndGuide> {
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
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 30.0),
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
                    style:
                        TextStyle(fontFamily: 'PretendardBold', fontSize: 18.0),
                  ),
                ),
                Container(
                  child: const TextField(
                    decoration: InputDecoration(
                        labelText: '연봉',
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)),
                  ),
                ),
                const SizedBox(
                  width: 60.0,
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('저장');
                  },
                  child: const Text('입력'),
                  /*
                  style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 80, 120, 194),
                        textStyle: TextStyle(fontFamily: 'PretendardLight', color: const Color.fromARGB(255, 255, 255, 255)),
                      ),*/
                )
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '앞으로',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
                      Text(
                        '4,250,000 원',
                        style: TextStyle(
                            fontFamily: 'PretendardBold', fontSize: 22.0),
                      ),
                      Text(
                        '신용카드 사용',
                        style: TextStyle(
                            fontFamily: 'PretendardBold', fontSize: 20.0
                            , color: Color.fromARGB(255, 80, 120, 194)),
                      ),
                      Text(
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '결제금액',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
                      Text(
                        '16,250,000 원',
                        style: TextStyle(
                            fontFamily: 'PretendardBold', fontSize: 20.0),
                      ),
                      Text(
                        '초과부터 카드소득공제를 받을 수 있어요',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 17.0),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontFamily: 'PretendardRegular', fontSize: 13.0),
                      ),
                      Text(
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
      )),
    );
  }
}
