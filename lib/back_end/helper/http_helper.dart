import 'dart:convert';
import 'dart:io';

import 'package:golocate/back_end/model/hotel.dart';
import 'package:http/http.dart' as http;

class HttpHelper{
  
  final String _urlBase = 'http://192.168.56.1:8000/hotel.json';

  Future<List?> getHotels() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final hotelsMap = jsonResponse;
      List hotels = hotelsMap.map((i) => Hotel.fromJson(i)).toList();
      return hotels;
    } else{
      return null;
    }
  }

  Future<List?> getHotels1() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final hotelsMap = jsonResponse;
      return hotelsMap;
    } else{
      return null;
    }
  }
}