import 'package:flutter/material.dart';

class WelFarePoint extends StatelessWidget {
  const WelFarePoint({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    '잔여포인트 : 1,400,000',
                    style:
                        TextStyle(fontFamily: 'PretendardBold', fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 10.0,
                    width: 330.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 212, 208, 208)),
                    child: Container(
                      width: 10,
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 80, 120, 194),
                      ),
                    ),
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
                      const Text('사용포인트             3,400,000',
                          style: TextStyle(fontFamily: 'PretendardBold')),
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
                      const Text('총 배정포인트        4,800,000',
                          style: TextStyle(fontFamily: 'PretendardBold')),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '분기 실적 충족 여부 : ',
                          style: TextStyle(
                              fontFamily: 'PretendardSemiBold', fontSize: 15.0),
                        ),
                        Text(
                          '500,000원',
                          style: TextStyle(
                              fontFamily: 'PretendardExtraBold',
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 194, 40, 40)),
                        ),
                        Text(
                          ' 부족',
                          style: TextStyle(
                              fontFamily: 'PretendardSemiBold', fontSize: 15.0),
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
                      Container(
                        height: 10.0,
                        width: 330.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromARGB(255, 212, 208, 208)),
                        child: Container(
                          width: 10,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 220.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromARGB(255, 80, 120, 194),
                          ),
                        ),
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
                          const Text(
                              '총 매출액(A)                            1,400,000 원',
                              style: TextStyle(fontFamily: 'PretendardRegular')),
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
                          const Text('포인트 사용 금액(B)                 1,200,000 원',
                              style: TextStyle(fontFamily: 'PretendardRegular')),
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
                          const Text('분기 실적 충족 금액(A-B)          200,000 원',
                              style: TextStyle(fontFamily: 'PretendardBold')),
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
                  onTap: () {
                    debugPrint('조회페이지로 이동');
                  },
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
              ],
            )
          ],
        ),
      )),
    );
  }
}
