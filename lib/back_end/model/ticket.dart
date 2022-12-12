class Ticket {
  int? id;
  int? userID;
  String? namaHotel;
  String? kota;
  int? price;
  String? checkIn;
  String? checkOut;
  String? rating;
  String? status;

  Ticket(
      {this.id,
      this.userID,
      this.namaHotel,
      this.kota,
      this.price,
      this.checkIn,
      this.checkOut,
      this.rating,
      this.status});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['user_id'] = userID;
    map['namaHotel'] = namaHotel;
    map['kota'] = kota;
    map['price'] = price;
    map['checkIn'] = checkIn;
    map['checkOut'] = checkOut;
    map['rating'] = rating;
    map['status'] = status;
    return map;
  }

  Ticket.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.userID = map['user_id'];
    this.namaHotel = map['namaHotel'];
    this.kota = map['kota'];
    this.price = map['price'];
    this.checkIn = map['checkIn'];
    this.checkOut = map['checkOut'];
    this.rating = map['rating'];
    this.status = map['status'];
  }
}
