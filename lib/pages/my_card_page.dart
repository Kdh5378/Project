import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:serious_python/serious_python.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:intl/intl.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  String _pyResult = "카드정보가 없습니다!";
  List<dynamic> _pythonList = [];
  List<dynamic> _cardList = [];
  List<dynamic> _benefitList = [];
  List<dynamic> _bokjiList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    String? pyResult;
    File? outFile;
    Directory tempDir = await (await getTemporaryDirectory()).createTemp("python_import");
    String resultFileName = path.join(tempDir.path, "python_import.txt");
    num totalUsedAmount = 0; // 합계를 저장할 변수 (num 타입으로 선언)
    print("결과 파일 이름: $resultFileName");

    try {
      await SeriousPython.run("app/app.zip", appFileName: "main.py",
        environmentVariables: {
          "RESULT_FILENAME": resultFileName,
        },
        sync: true,
      );

      //resultFileName = "output.text";
      outFile = File(resultFileName);
      print("$resultFileName");

      // try reading out.txt in a loop
      var i = 10;
      while (i-- > 0) {
        if (await outFile.exists()) {
          pyResult = await outFile.readAsString();
          print(pyResult);

          // JSON 파싱
          try {
            // JSON 문자열을 List<dynamic>으로 변환
            _pythonList = json.decode(pyResult);
            _cardList = _pythonList[0];
            _benefitList = _pythonList[1];
            _bokjiList = _pythonList[2];
            print(_pythonList);

            // _bokjiList의 resUsedAmount 항목들을 모두 더하기
            for (var bokji in _bokjiList) {
              if (bokji is Map && bokji['resUsedAmount'] != null) {
                var usedAmount = bokji['resUsedAmount'];

                // usedAmount가 문자열인 경우 숫자로 변환
                if (usedAmount is String) {
                  totalUsedAmount += num.tryParse(usedAmount) ?? 0; // 문자열을 숫자로 변환, 변환 실패 시 0 추가
                } else if (usedAmount is num) {
                  totalUsedAmount += usedAmount; // 이미 num 타입인 경우
                }
              }
            }

            // 숫자에 쉼표 추가
            String formattedAmount = NumberFormat("#,##0").format(totalUsedAmount);

            // 필터링된 카드 정보 업데이트
            setState(() {
              _pyResult = "현재까지 사용된 복지 포인트는 총 $formattedAmount 원 입니다."; // 결과 업데이트
            });

          } catch (e) {
            print('예외 발생: $e');
            setState(() {
              _pyResult = "데이터 파싱 오류!";
            });
          }
          break; // 성공적으로 파일을 읽은 경우 반복문 종료
        } else {
          print("파일이 아직 생성되지 않았습니다. ${20 - i}");
          await Future.delayed(const Duration(seconds: 1));
        }
      }

    } catch (e) {
      print('실행 오류: $e');
      setState(() {
        _pyResult = "Python 실행 오류!";
      });
    } finally {
      // 리소스 정리
      if (outFile != null && await outFile.exists()) {
        await outFile.delete();
      }
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _pyResult = "정보를 읽어오는 중입니다. 잠시만 기다려주세요.";
                      });
                    await initPlatformState();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    '불러오기',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _pyResult,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Text(
                  '내 카드',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cardList.length,
                  itemBuilder: (context, index) {
                    var card = _cardList[index];
                    var benefit = _benefitList[index]['resCardBenefitList'];

                    if (card['resCardName'] == _benefitList[index]['resCardName'] && 
                        card['resCardType'] != "가족" && card['resSleepYN'] == "N") {
                      var cardType = card['resCardName'].contains('체크') ? "체크카드" : "신용카드";

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(card['resCardName']),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('카드 혜택'),
                                      const SizedBox(height: 10),
                                      if (card['resImageLink'] != null)
                                        Image.network(
                                          card['resImageLink'],
                                          width: 200,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      const SizedBox(height: 10),
                                      if (benefit != null && benefit.isNotEmpty)
                                        ...benefit.map((benefitItem) {
                                          String displayText =
                                              (benefitItem['resCardBenefitName']?.isNotEmpty ?? false)
                                                  ? benefitItem['resCardBenefitName']
                                                  : (benefitItem['resType']?.isNotEmpty ?? false)
                                                      ? benefitItem['resType']
                                                      : '정보 없음';
                                          return Text('- $displayText');
                                        }).toList()
                                      else
                                        const Text('해당 카드에 대한 혜택이 없습니다.'),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('닫기'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: const Color(0xFF1F2123),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card['resCardName'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      cardType,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
=======

class MyCardPage extends StatelessWidget {
  const MyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 카드',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'PretendardBold',
                    ),
                  ),
                  Text(
                    '모두보기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'PretendardLight',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 38, 72, 146),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '농협카드',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'PretendardExtraBold',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '신용',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                  fontFamily: 'PretendardSemiBold',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Transform.scale(
                        scale: 2.2,
                        child: Transform.translate(
                          offset: const Offset(-5, 0),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
>>>>>>> 98066d2929e3855b1c5f4e5d803cbcd7980e74e6
          ),
        ),
      ),
    );
  }
}
