import 'package:http/http.dart';

class CenterData{
  String centerName;
  String regionName;
  String centerLocate;
  String centerPhone;


CenterData(
  {
 required this.centerLocate,
 required this.regionName,
 required this.centerName,
 required this.centerPhone,
  }
);

}