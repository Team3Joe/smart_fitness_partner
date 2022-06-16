import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:korean_fitness/Analysis/center_items.dart';
import 'package:http/http.dart' as http;
import 'package:korean_fitness/message.dart';
import 'package:korean_fitness/message3.dart';

class CenterList extends StatefulWidget {
  final List<CenterData> list;


  CenterList({Key? key, required this.list}) : super(key: key);

  @override
  State<CenterList> createState() => _CenterListState();
}

class _CenterListState extends State<CenterList> {

  final ScrollController _scrollController = ScrollController();
  late List data;
  late List mRegion;
  late List locate_data;
  late int page;
  late String nowTap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = [];
    locate_data = [];
    mRegion = [
      '전국',
      '서울',
      '부산',
      '대구',
      '인천',
      '광주',
      '대전',
      '울산',
      '경기',
      '강원',
      '충북',
      '충남',
      '전북',
      '전남',
      '경북',
      '경남',
      '제주',
      '세종'
    ];
    page = 0;
    nowTap = '전국';

    getJSONData();

  _scrollController.addListener(() {
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange

){    getJSONData();

    }
  });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$nowTap',
        style: TextStyle(
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(5, 5),
                    blurRadius:10
                  )
                ]
              ),
        ),
        backgroundColor: Color.fromARGB(230, 73, 39, 174),
        toolbarHeight: 75,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(220, 200, 167, 238),
              height: 65,
              child: data.isEmpty
                  ? const Text("데이터가 없습니다.")
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mRegion.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                        setState(() {
                                        nowTap = mRegion[position];
                                      });
                                      tap(position);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(200, 96, 60, 205),
                                    ),
                                    child: Text(
                                      mRegion[position],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                      ),
                                    )
                                  ),
                              )
                            ],
                          ),
                        );
                      }),
            ),
            Container(
              width: 400,
              height: 700,
              child: ListView.builder(
                controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        locateGetJSONData(data[position]['mid']);
                
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "images/korea.png",
                                        width: 180,
                                        height: 80,
                                      ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[position]['mName'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                      Text(
                                        " Tel: " + data[position]['mTell'],
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 103, 103, 103),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(data[position]['mAddress'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 89, 89, 89),
                                      fontSize: 11
                                    ),
                                  ),
                            ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getJSONData() async {





    if (nowTap == '전국'){
   var url = Uri.parse('http://localhost:8080/Flutter/fitness/center_datas_all.jsp?page=$page');
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSOn = json.decode(utf8.decode(response.bodyBytes));

      List result = dataConvertedJSOn['results'];

      data.addAll(result);

      page += 1;
      
    });
    }else{

      var url = Uri.parse(
          'http://localhost:8080/Flutter/fitness/center_datas_region_offset.jsp?page=$page&mRegion=$nowTap'
              );
      var response = await http.get(url);
      setState(() {
      var dataConvertedJSOn = json.decode(utf8.decode(response.bodyBytes));

      List result = dataConvertedJSOn['results'];

      data.addAll(result);

      page += 1;
   

    
    });

      
    }
    
 

    // print(result);

    return true;
  }

  Future<bool> regionGetJSONData(int index) async {

    data = [];



      var url = Uri.parse(
          'http://localhost:8080/Flutter/fitness/center_datas.jsp?mRegion=' +
              mRegion[index]);
      var response = await http.get(url);
      setState(() {
      var dataConvertedJSOn = json.decode(utf8.decode(response.bodyBytes));

      List result = dataConvertedJSOn['results'];

      data.addAll(result);
   

    
    });

    // print(result);

    return true;
  }


  tap(int index){
    if (mRegion[index] == '전국'){
      data = [];
      page = 0;
      getJSONData();

    }else{
      page = 0;
      regionGetJSONData(index);
    }


  }

  Future<bool> locateGetJSONData(int mId) async {

        showDialog(
      context: context
    , builder: (context){

      return Center(child: CircularProgressIndicator());
    },);


    locate_data = [];

    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/center_datas_locate.jsp?mId=$mId");
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSOn = json.decode(utf8.decode(response.bodyBytes));

      List result = dataConvertedJSOn['results'];

      locate_data.addAll(result);

      Message3.mLatitude = locate_data[0]["mLatitude"].toString();
      Message3.mLongtitude = locate_data[0]["mlongitude"].toString();
    });

    //  print(double.parse(Message3.mLatitude));

    // print(result);

            Timer(Duration(seconds: 1), () {
       
          Navigator.pop(context);
          Navigator.pushNamed(context, '/Center_map');
                          });

    return true;
  }
}