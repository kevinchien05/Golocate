import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golocate/components/page/home_screen.dart';
import 'package:golocate/components/page/hotel_screen.dart';
import 'package:golocate/components/page/profile_page.dart';

class HomeProvider with ChangeNotifier {
  //bottom navbar
  int _currentIndex = 0;

  int get getCurrent => _currentIndex;

  void setCurrent(int val) {
    _currentIndex = val;
    notifyListeners();
  }

  //List Halaman Home Page
  final List _listPage = const [HomeScreen(), HotelScreen(), ProfilePage()];

  List get getListPage => _listPage;


  //Search
  List _tmpList = [];

  List get getTmpList => _tmpList;

  void clearTmp(){
    _tmpList.clear();
    notifyListeners();
  }

  void setTmp(val){
    _tmpList.add(val);
    notifyListeners();
  }

  final TextEditingController _searchHomeController = TextEditingController();

  TextEditingController get getHomeSearch => _searchHomeController;

  bool _found = true;

  bool get getFound => _found;

  set setFound(val){
    _found = val;
    notifyListeners();
  }



  //List kota
  final List _listKota = [
    {'namaKota': 'Medan', 'gambar': 'assets/kotaMedan.png'},
    {'namaKota': 'Jakarta', 'gambar': 'assets/kotaJakarta.png'},
    {'namaKota': 'Bali', 'gambar': 'assets/kotaBali.png'},
  ];

  List get getListKota => _listKota;

  bool _isKota = false;
  
  bool get getIsKota => _isKota;

  set setIsKota(val){
    _isKota = val;
    notifyListeners();
  }

  String _namaKota = '';

  String get getNamaKota => _namaKota;

  void setNamaKota(String string) {
    _namaKota = string;
    notifyListeners();
  }

}
