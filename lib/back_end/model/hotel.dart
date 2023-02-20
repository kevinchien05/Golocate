class Hotel {
  late int id;
  late String nama;
  late String kota;
  late int harga;
  late double rating;
  late String gambar;
  late int tamu;
  late int kasur;
  late int mandi;
  late String des;

  Hotel(this.id, this.nama, this.kota, this.harga, this.rating, this.gambar,
      this.kasur, this.mandi, this.tamu, this.des);

  Hotel.fromJson(Map<String,dynamic> parsedJson) {
    id = parsedJson['id'];
    nama = parsedJson['nama_hotel'];
    kota = parsedJson['kota'];
    harga = parsedJson['harga'];
    rating = parsedJson['rating'];
    gambar = parsedJson['gambar'];
    tamu = parsedJson['keterangan']['tamu'];
    kasur = parsedJson['keterangan']['kasur'];
    mandi = parsedJson['keterangan']['mandi'];
    des = parsedJson['des'];
  }
}
