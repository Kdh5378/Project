import 'package:flutter/material.dart';
import 'package:card_upgo_run/pages/main_page.dart';
import 'package:card_upgo_run/pages/my_card_page.dart';
import 'package:card_upgo_run/pages/my_report_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static const String _title = 'Main Page';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title, 
      home: CardUpgoRunPage());
  }
}

class CardUpgoRunPage extends StatefulWidget {
  const CardUpgoRunPage({super.key});

  @override
  State<CardUpgoRunPage> createState() => _MainPageState();
}

class _MainPageState extends State<CardUpgoRunPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    const MyCardPage(),
    const MainPage(),
    const MyReportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dns),
            label: '내 카드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste_search),
            label: '분석리포트',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontFamily: 'PretendardBold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'PretendardBold'),
      ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
