import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:korean_fitness/message3.dart';

class CenterMap extends StatefulWidget {
  late final String title;
  // late double mLatitude = double.parse(Message3.mLatitude);
  //  late double mLongtitude = double.parse(Message3.mLatitude);
  @override
  _CenterMapState createState() => _CenterMapState();

}


class _CenterMapState extends State<CenterMap> {
  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController _controller;
  

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(double.parse(Message3.mLatitude), double.parse(Message3.mLongtitude)
),
      zoom: 16, //확대
      );

  final List<Marker> markers = [];
      
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  markers.add(Marker(
       markerId: MarkerId("1"),
       draggable: true,
       onTap: () => print("Marker!"),
       position: LatLng(double.parse(Message3.mLatitude), double.parse(Message3.mLongtitude)
)));

  }


  // 지도 클릭 시 표시할 장소에 대한 마커 목록


  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(230, 87, 51, 194),
        toolbarHeight: 75,
        elevation: 0,
        title: Text('체력인증센터 위치'),
      ),
        body: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          markers: markers.toSet(),

          // 클릭한 위치가 중앙에 표시
          onTap: (cordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
            // addMarker(cordinate);
           
          },
        ),

        // floatingActionButton 클릭시 줌 아웃
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.animateCamera(CameraUpdate.zoomOut());
          },
          child: Icon(Icons.zoom_out),
        )
        );
  }
}