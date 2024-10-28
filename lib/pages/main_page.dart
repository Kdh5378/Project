import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:card_upgo_run/pages/map_guide.dart';
import 'package:card_upgo_run/pages/year_end_guide.dart';
import 'package:card_upgo_run/pages/welfare_point_guide.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String storeName = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchStoreName();
  }

  Future<void> fetchStoreName() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore.instance
          .collection('store-info')
          .doc('storeId1')
          .get();

      if (document.exists && document.data() != null) {
        setState(() {
          storeName = document.data()!['name'];
        });
      } else {
        setState(() {
          storeName = 'No data found';
        });
      }
    } catch (e) {
      setState(() {
        storeName = 'Error fetching data';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            '카드업고튀어 .',
            style: TextStyle(
              fontFamily: 'PretendardBlack',
              color: Color.fromARGB(255, 80, 120, 194),
              fontSize: 29.0,
              letterSpacing: -3.0,
            ),
          ),
          leading: const Column(
            children: <Widget>[
              Icon(
                Icons.run_circle,
                color: Color.fromARGB(255, 80, 120, 194),
                size: 50,
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Store Name: $storeName',  // Firestore에서 가져온 데이터를 표시하는 부분
                style: const TextStyle(
                  fontFamily: 'PretendardSemiBold',
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 150,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapGuide()),
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 50, 80, 146),
                            border: Border.all(
                                color: const Color.fromARGB(255, 50, 80, 146),
                                width: 3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                              child: Column(
                            children: [
                              Text(
                                '지도에서\n가게별 최대혜택 보기',
                                style: TextStyle(
                                    fontFamily: 'PretendardSemiBold',
                                    fontSize: 25.0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.map,
                                color: Colors.white,
                                size: 40,
                              ),
                            ],
                          ))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const YearEndGuide()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 50, 80, 146),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 50, 80, 146),
                                    width: 3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                child: Text(
                                  '연말정산\n가이드',
                                  style: TextStyle(
                                      fontFamily: 'PretendardSemiBold',
                                      fontSize: 22.0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 140,
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelFarePoint()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 50, 80, 146),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 50, 80, 146),
                                    width: 3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                child: Text(
                                  '복지포인트\n잔액',
                                  style: TextStyle(
                                      fontFamily: 'PretendardSemiBold',
                                      fontSize: 22.0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
