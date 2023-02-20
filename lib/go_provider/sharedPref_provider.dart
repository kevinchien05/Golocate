import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class isGelap with ChangeNotifier {
  bool isOn = false;
  bool get getOn => isOn;
  set setOn(val){
    isOn = val;
    notifyListeners();
  }

  bool isDark = false;
  bool get getDark => isOn;
  set setDark(val){
    isDark = val;
    notifyListeners();
  }

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    primarySwatch: Colors.amber,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: const BorderSide(
          color: Colors.black,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  Future<void> setPreference() async {
    final jembatan = await SharedPreferences.getInstance();

    final myData = json.encode({
      'isDark': isDark.toString(),
      'isOn' : isOn.toString()
    });

    jembatan.setString('myData', myData);
  }

  Future<void> getPreference() async {
    final jembatan = await SharedPreferences.getInstance();

    if (jembatan.containsKey('myData')) {
      final myData =
          json.decode(jembatan.getString('myData')??'Data Null') as Map<String, dynamic>;

      isOn = myData["isOn"] == "true" ? true : false;
      isDark = myData["isDark"] == "true" ? true : false;
    }
  }

  void changeTheme(){
    setPreference();
    isDark = !isDark;
    isOn = !isOn;
  }
}
