import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  int idUser = 1;

  int get getIdUser => idUser;

  set setIdUser(val){
    idUser = val;
    notifyListeners();
  }

  //List User Register
  final List<Map<String, String>> userList = [
    { 
      'user_id' : '1',
      'username': 'Kevin',
      'email': 'a',
      'password': 'a',
      'point': '0',
      'phone': '-',
      'gender': '-',
      'birth': '-',
      'place': '-',
      'bio': '-'
    }
  ];
  List<Map<String, String>> get getUserList => userList;
  set setUserList(val) {
    userList.add(val);
    notifyListeners();
  }

  //List user sedang login
  final List<Map<String, String>> activeUser = [];
  List<Map<String, String>> get getActiveUser => activeUser;
  set setActiveUser(val) {
    activeUser.add(val);
    notifyListeners();
  }

  void removeUser(){
    activeUser.clear();
    notifyListeners();
  }

  // untuk see/unsee password
  bool _isPassHide = true;
  bool _isConHide = true;

  bool get getPassHide => _isPassHide;

  void setPassHide() {
    _isPassHide = !_isPassHide;
    notifyListeners();
  }

  bool get getConHide => _isConHide;

  void setConHide() {
    _isConHide = !_isConHide;
    notifyListeners();
  }

  // mengecek textfield kosong/tidak
  bool _usernameEmpty = false;
  bool _emailEmpty = false;
  bool _passEmpty = false;
  bool _conEmpty = false;

  bool get getUsernameEmpty => _usernameEmpty;
  bool get getEmailEmpty => _emailEmpty;
  bool get getPassEmpty => _passEmpty;
  bool get getConEmpty => _conEmpty;

  set setUsernameEmpty(val) {
    _usernameEmpty = val;
    notifyListeners();
  }

  set setEmailEmpty(val) {
    _emailEmpty = val;
    notifyListeners();
  }

  set setPassEmpty(val) {
    _passEmpty = val;
    notifyListeners();
  }

  set setConEmpty(val) {
    _conEmpty = val;
    notifyListeners();
  }

  //mengecek password dan confirm password benar
  bool _passRight = false;
  bool _conRight = false;

  bool get getPassRight => _passRight;

  set setPassRight(val) {
    _passRight = val;
    notifyListeners();
  }

  bool get getConRight => _conRight;

  set setConRight(val) {
    _conRight = val;
    notifyListeners();
  }

  //Login Page
  //Mengecek textfield kosong
  bool _loginEmail = false;
  bool _loginPass = false;

  bool get getLoginEmail => _loginEmail;
  bool get getLoginPass => _loginPass;

  set setLoginEmail(val) {
    _loginEmail = val;
    notifyListeners();
  }

  set setLoginPass(val) {
    _loginPass = val;
    notifyListeners();
  }

  //see atau unsee password
  bool _loginPassHide = true;

  bool get getLoginPassHide => _loginPassHide;

  void setLoginPassHide() {
    _loginPassHide = !_loginPassHide;
    notifyListeners();
  }

  //mengecek Email dan Pass di userList
  bool _loginRight = false;
  bool _loginPassRight = false;

  bool get getLoginRight => _loginRight;
  bool get getLoginPassRight => _loginPassRight;

  set setLoginRight(val) {
    _loginRight = val;
    notifyListeners();
  }

  set setLoginPassRight(val) {
    _loginPassRight = val;
    notifyListeners();
  }

  //Forget Page
  //Mengecek TextField Kosong
  bool _forgetEmailEmpty = false;
  bool _forgetPassEmpty = false;
  bool _forgetNewEmpty = false;

  bool get getForgetEmailEmpty => _forgetEmailEmpty;
  bool get getForgetPassEmpty => _forgetPassEmpty;
  bool get getForgetNewEmpty => _forgetNewEmpty;

  set setForgetEmailEmpty(val) {
    _forgetEmailEmpty = val;
    notifyListeners();
  }

  set setForgetPassEmpty(val) {
    _forgetPassEmpty = val;
    notifyListeners();
  }

  set setForgetNewEmpty(val) {
    _forgetNewEmpty = val;
    notifyListeners();
  }

  //see atau unsee password
  bool _isForgetPassHide = true;
  bool _isForgetNewHide = true;

  bool get getForgetPassHide => _isForgetPassHide;

  void setForgetPassHide() {
    _isForgetPassHide = !_isForgetPassHide;
    notifyListeners();
  }

  bool get getForgetNewHide => _isForgetNewHide;

  void setForgetNewHide() {
    _isForgetNewHide = !_isForgetNewHide;
    notifyListeners();
  }

  //Mengecek panjang password
  bool _forgetOldRight = false;
  bool _forgetNewRight = false;

  bool get getForgetOldRight => _forgetOldRight;
  bool get getForgetNewRight => _forgetNewRight;

  set setForgetOldRight(val) {
    _forgetOldRight = val;
    notifyListeners();
  }

  set setForgetNewRight(val) {
    _forgetNewRight = val;
    notifyListeners();
  }

  //Mengecek email
  bool _forgetEmailRight = false;

  bool get getForgetEmailRight => _forgetEmailRight;

  set setForgetEmailRight(val) {
    _forgetEmailRight = val;
    notifyListeners();
  }

  void changePass(i, newPass) {
    userList[i]['password'] = newPass;
    notifyListeners();
  }

  void changePoint(newPoint){
    activeUser[0]['point'] = newPoint.toString();
    notifyListeners();
  }

  void userPoint(i, newPoint){
    userList[i]['point'] = newPoint.toString();
    notifyListeners();
  }

  //Profile page
  final TextEditingController _userController = TextEditingController();

  TextEditingController get getUserController => _userController;

  final TextEditingController _phoneController = TextEditingController();

  TextEditingController get getPhoneController => _phoneController;

  final TextEditingController _genderController = TextEditingController();

  TextEditingController get getGenderController => _genderController;

  final TextEditingController _birthController = TextEditingController();

  TextEditingController get getBirthController => _birthController;

  final TextEditingController _placeController = TextEditingController();

  TextEditingController get getPlaceController => _placeController;

  final TextEditingController _bioController = TextEditingController();

  TextEditingController get getBioController => _bioController;

  void changeBio(i,newUser,newPhone,newGender,newBirth,newPlace,newBio){
    userList[i]['username'] = newUser;
    userList[i]['phone'] = newPhone;
    userList[i]['gender'] = newGender;
    userList[i]['birth'] = newBirth;
    userList[i]['place'] = newPlace;
    userList[i]['bio'] = newBio;
    activeUser[0]['username'] = newUser;
    activeUser[0]['phone'] = newPhone;
    activeUser[0]['gender'] = newGender;
    activeUser[0]['birth'] = newBirth;
    activeUser[0]['place'] = newPlace;
    activeUser[0]['bio'] = newBio;
    notifyListeners();
  }

}
