import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapGuide extends StatefulWidget {
  const MapGuide({super.key});

  @override
  _MapState createState() => _MapState();
}

class CardInfo {
  final String cardName;
  final String cardBenefit;

  CardInfo({required this.cardName, required this.cardBenefit});

  // Firestore 데이터를 CardInfo 객체로 변환
  factory CardInfo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardInfo(
      cardName: data['cardName'] ?? '',
      cardBenefit: data['cardBenefit'] ?? '',
    );
  }
}

Future<List<CardInfo>> fetchCardInfo() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    QuerySnapshot querySnapshot = await firestore.collection('cardInfo').get();
    print('Data fetched: ${querySnapshot.docs}'); // 데이터를 콘솔에 출력
    return querySnapshot.docs
        .map((doc) => CardInfo.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching data: $e");
    return [];
  }
}

class _MapState extends State<MapGuide> {
  GoogleMapController? _controller;
  LatLng _currentPosition =
      const LatLng(37.367361548699, 127.00352984472); // 기본 위치(백운호수)
  LatLng? _selectedLocation;
  String _placeName = 'Tap on the map to get location name'; // 초기 상태
  Position? position;
  String _placeType = 'restaurant'; // 기본 값으로 음식점 설정
  Set<Marker> _markers = {};
  late Future<List<CardInfo>> _cardInfoFuture; // Firestore 데이터 저장할 변수

  final String apiKey =
      'AIzaSyBwU2k7FAkYpAr0ajinUHsN3PZ2bBdwSYU'; // 여기에 API 키를 입력하세요.

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _cardInfoFuture = fetchCardInfo(); // Firestore에서 데이터 가져오기
  }

  // 현재 위치 가져오기
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    });
  }

  // 장소명 가져오기 및 바텀 시트 표시
  Future<void> _getPlaceName(LatLng position) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${position.latitude},${position.longitude}'
        '&radius=100' // 100m 반경 내 검색
        '&type=$_placeType' // 식당 유형 필터
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          setState(() {
            _placeName = data['results'][0]['name'] ?? 'No place found';
          });
        } else {
          setState(() {
            _placeName = 'No place found in this location';
          });
        }
      } else {
        setState(() {
          _placeName = 'Failed to fetch place data';
        });
      }
      // 장소명을 가져온 후 바텀 시트 표시
      _showPlaceNameBottomSheet(context);
    } catch (e) {
      setState(() {
        _placeName = 'Error occurred: $e';
      });
    }
  }

  // 장소 필터링 및 마커 표시
  Future<void> _filterPlaces(String type) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${_currentPosition.latitude},${_currentPosition.longitude}'
        '&radius=1000' // 1km 반경 내 검색
        '&type=$type' // 선택한 업종 필터
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Set<Marker> markers = {};

        for (var result in data['results']) {
          LatLng position = LatLng(result['geometry']['location']['lat'],
              result['geometry']['location']['lng']);
          markers.add(Marker(
            markerId: MarkerId(result['place_id']),
            position: position,
            infoWindow: InfoWindow(
              title: result['name'], // 마커 위에 표시할 장소명
            ),
            onTap: () {
              // 마커 클릭 시 바텀 시트 표시
              setState(() {
                _placeName = result['name'];
              });
              _showPlaceNameBottomSheet(context);
            },
          ));
        }

        setState(() {
          _markers = markers; // 필터링된 마커로 업데이트
        });
      } else {
        print('Failed to fetch place data');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // 바텀 시트를 표시하는 메서드 (Firestore 데이터를 사용)
  void _showPlaceNameBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _placeName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  '혜택이 큰 카드 순이에요.\n맨위의 카드로 결제하시면 개이득!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('cardInfo')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading data'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }

                      final cardInfos = snapshot.data!.docs
                          .map((doc) => CardInfo.fromFirestore(doc))
                          .toList();

                      return ListView.builder(
                        itemCount: cardInfos.length,
                        itemBuilder: (context, index) {
                          final card = cardInfos[index];
                          return ListTile(
                            leading: const Icon(Icons.card_giftcard),
                            title: Text(card.cardName),
                            subtitle: Text(
                              card.cardBenefit,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '지도에서 혜택찾기',
            style: TextStyle(fontFamily: 'PretendardLight'),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller = controller;
                });
              },
              myLocationEnabled: true, // 현재 위치를 지도에 표시
              myLocationButtonEnabled: true, // 현재 위치로 가는 버튼 활성화
              markers: _markers,
              onTap: (LatLng position) {
                _getPlaceName(position);
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 음식점 필터링
                    _filterPlaces('restaurant');
                    setState(() {
                      _placeType = 'restaurant';
                    });
                  },
                  child: const Text('음식점'),
                ),
                const SizedBox(width: 10), // 사이 공간 추가
                ElevatedButton(
                  onPressed: () {
                    // 카페 필터링
                    _filterPlaces('cafe');
                    setState(() {
                      _placeType = 'cafe';
                    });
                  },
                  child: const Text('카페'),
                ),
                const SizedBox(width: 10), // 사이 공간 추가
                ElevatedButton(
                  onPressed: () {
                    // 주유소 필터링
                    _filterPlaces('gas_station');
                    setState(() {
                      _placeType = 'gas_station';
                    });
                  },
                  child: const Text('주유소'),
                ),
                // 필요에 따라 더 많은 버튼 추가
              ],
            ),
          ),
          // 구역 아래쪽에 고정된 텍스트 추가
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 119, 159, 234), // 배경색
                  borderRadius: BorderRadius.circular(10), // 둥근 모서리
                ),
                child: const Text(
                  '지도에서 장소를 선택해보세요.', // 고정된 텍스트
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'PretendardRegular',
                    color: Colors.white,
                    // 텍스트 중앙 정렬
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
