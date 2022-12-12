import 'package:flutter/material.dart';

class RatingProvider with ChangeNotifier{
  bool _star1 = false;
  bool get getStar1 => _star1;
  set setStar1(val){
    _star1 = val;
    notifyListeners();
  }

  bool _star2 = false;
  bool get getStar2 => _star2;
  set setStar2(val){
    _star2 = val;
    notifyListeners();
  }

  bool _star3 = false;
  bool get getStar3 => _star3;
  set setStar3(val){
    _star3 = val;
    notifyListeners();
  }

  bool _star4 = false;
  bool get getStar4 => _star4;
  set setStar4(val){
    _star4 = val;
    notifyListeners();
  }

  bool _star5 = false;
  bool get getStar5 => _star5;
  set setStar5(val){
    _star5 = val;
    notifyListeners();
  }

  bool _thumb1 = false;
  bool get getThumb1 => _thumb1;
  set setThumb1(val){
    _thumb1 = val;
    notifyListeners();
  }

  bool _thumb2 = false;
  bool get getThumb2 => _thumb2;
  set setThumb2(val){
    _thumb2 = val;
    notifyListeners();
  }

  bool _thumb3 = false;
  bool get getThumb3 => _thumb3;
  set setThumb3(val){
    _thumb3 = val;
    notifyListeners();
  }

  bool _thumb4 = false;
  bool get getThumb4 => _thumb4;
  set setThumb4(val){
    _thumb4 = val;
    notifyListeners();
  }

  bool _thumb5 = false;
  bool get getThumb5 => _thumb5;
  set setThumb5(val){
    _thumb5 = val;
    notifyListeners();
  }

  bool _thumb6 = false;
  bool get getThumb6 => _thumb6;
  set setThumb6(val){
    _thumb6 = val;
    notifyListeners();
  }

  bool _thumb7 = false;
  bool get getThumb7 => _thumb7;
  set setThumb7(val){
    _thumb7 = val;
    notifyListeners();
  }

  bool _thumb8 = false;
  bool get getThumb8 => _thumb8;
  set setThumb8(val){
    _thumb8 = val;
    notifyListeners();
  }

  bool _thumb9 = false;
  bool get getThumb9 => _thumb9;
  set setThumb9(val){
    _thumb9 = val;
    notifyListeners();
  }

  bool _thumb10 = false;
  bool get getThumb10 => _thumb10;
  set setThumb10(val){
    _thumb10 = val;
    notifyListeners();
  }
}