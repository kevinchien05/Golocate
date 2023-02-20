import 'package:flutter/material.dart';
import 'package:golocate/back_end/model/ticket.dart';

class TiketProvider with ChangeNotifier {
  List<Ticket> _ticketList = [];

  List<Ticket> get getTicketList => _ticketList;

  set setTicketList(val) {
    _ticketList.add(val);
    notifyListeners();
  }

  void clearTicket(){
    _ticketList.clear();
  }

  String _rating = '';

  String get getRating => _rating;
  
  set setRating(val){
    _rating = val;
    notifyListeners();
  }

  /*void changeRating(i, newRate) {
    _ticketList[i]['rating'] = newRate;
    notifyListeners();
  }

  void changeStatus(i, newStat) {
    _ticketList[i]['status'] = newStat;
    notifyListeners();
  }*/

  DateTimeRange _checkDate = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 1)));
  
  DateTimeRange get getCheckDate => _checkDate;

  set setCheckDate(val){
    _checkDate = val;
    notifyListeners();
  }

  bool _switch = false;

  bool get getSwitch => _switch;

  set setSwitch(val) {
    _switch = val;
    notifyListeners();
  }

  dynamic _total = 0;

  dynamic get getTotal => _total;

  set setTotal(val) {
    _total = val;
    notifyListeners();
  }

  dynamic _point = 0;

  dynamic get getPoint => _point;

  set setPoint(val) {
    _point = val;
    notifyListeners();
  }

  bool _chip1 = false;

  bool get getChip1 => _chip1;

  set setChip1(val) {
    _chip1 = val;
    notifyListeners();
  }

  bool _chip2 = false;

  bool get getChip2 => _chip2;

  set setChip2(val) {
    _chip2 = val;
    notifyListeners();
  }

  bool _chip3 = false;

  bool get getChip3 => _chip3;

  set setChip3(val) {
    _chip3 = val;
    notifyListeners();
  }

  bool _chip4 = false;

  bool get getChip4 => _chip4;

  set setChip4(val) {
    _chip4 = val;
    notifyListeners();
  }

  List _chipTemp = [];

  List get getChip => _chipTemp;

  void addChip(val) {
    _chipTemp.add(val);
    notifyListeners();
  }

  void removeChip() {
    _chipTemp.clear();
    notifyListeners();
  }

  TextEditingController _minRate = TextEditingController();

  TextEditingController get getMinRate => _minRate;

  TextEditingController _maxRate = TextEditingController();

  TextEditingController get getMaxRate => _maxRate;

  TextEditingController _minPrice = TextEditingController();

  TextEditingController get getMinPrice => _minPrice;

  TextEditingController _maxPrice = TextEditingController();

  TextEditingController get getMaxPrice => _maxPrice;

  //voucher
  final List _voucherList = [
    {
      'icon': Icons.local_taxi,
      'nama': 'Hot Deals',
      'valid': '31 Oct 2022',
      'status': '0'
    },
    {
      'icon': Icons.fastfood_rounded,
      'nama': 'Free Dinner',
      'valid': '31 Oct 2022',
      'status': '0'
    },
    {
      'icon': Icons.fastfood_rounded,
      'nama': 'Free Breakfast',
      'valid': '31 Oct 2022',
      'status': '0'
    },
  ];

  List get getVoucherList => _voucherList;

  void changeVoucher(i, newStatus) {
    _voucherList[i]['status'] = newStatus;
    notifyListeners();
  }

  List _voucherActive = [];

  List get getVoucherActive => _voucherActive;

  set setVoucherActive(val) {
    _voucherActive.add(val);
    notifyListeners();
  }

  void removeVoucher() {
    _voucherActive.clear();
    notifyListeners();
  }
}
