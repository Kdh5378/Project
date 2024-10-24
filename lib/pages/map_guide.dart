import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:card_upgo_run/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapGuide extends StatefulWidget {
  const MapGuide({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapGuide> {
  GoogleMapController? _controller;
  LatLng _currentPosition =
      const LatLng(37.367361548699, 127.00352984472); // 기본 위치(백운호수)
  LatLng? _selectedLocation;
  String _placeName = 'Tap on the map to get location name'; // 초기 상태

  final String apiKey = 'AIzaSyBwU2k7FAkYpAr0ajinUHsN3PZ2bBdwSYU';

  final List<String> _places = [
    'Restaurant 1',
    'Restaurant 2',
    'Restaurant 3',
    'Restaurant 4',
    'Restaurant 5',
  ];

  num myPercent = 85;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

  Future<void> _getPlaceName(LatLng position) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${position.latitude},${position.longitude}'
        '&radius=100' // 100m 반경 내 검색
        '&type=restaurant' // 식당 유형 필터
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          // 첫 번째 결과에서 장소명 가져오기
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
    } catch (e) {
      setState(() {
        _placeName = 'Error occurred: $e';
      });
    }
  }

  Color getCorrectColor(num tmpNum) {
    if (tmpNum >= 80) {
      return const Color.fromARGB(255, 124, 170, 255);
    } else {
      return const Color.fromARGB(255, 161, 157, 157);
    }
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
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
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
              onTap: (LatLng position) {
                setState(() {
                  _selectedLocation = position;
                });
                _getPlaceName(position);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          if (_selectedLocation != null)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 80, 120, 194), // 배경색
                  borderRadius: BorderRadius.circular(10), // 둥근 모서리
                ),
                child: Row(
                  children: [
                    const Text(
                      '선택한 장소: ', // 고정된 텍스트
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PretendardRegular',
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        _placeName, // 선택된 장소명
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'PretendardBold',
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis, // 길면 생략 표시
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          // ListView 부분
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.place),
                  title: Text(_places[index]),
                  onTap: () {
                    // 클릭 시 동작을 추가할 수 있음
                    print('${_places[index]} tapped');
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
