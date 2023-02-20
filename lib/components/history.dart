import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  String? id;
  int? userID;
  String? namaHotel;
  String? kota;
  int? price;
  String? checkIn;
  String? checkOut;
  String? rating;
  String? status;

  HistoryModel(
      {this.id,
      required this.userID,
      required this.namaHotel,
      required this.kota,
      required this.price,
      required this.checkIn,
      required this.checkOut,
      required this.rating,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'namaHotel': namaHotel,
      'kota': kota,
      'price': price,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'rating': rating,
      'status': status
    };
  }

  HistoryModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userID = doc.data()?['user_id'],
        namaHotel = doc.data()?['namaHotel'],
        kota = doc.data()?['kota'],
        price = doc.data()?['price'],
        checkIn = doc.data()?['checkIn'],
        checkOut = doc.data()?['checkOut'],
        rating = doc.data()?['rating'],
        status = doc.data()?['status'];
}
