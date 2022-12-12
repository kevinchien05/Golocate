import 'package:flutter/material.dart';

class HotelWidget extends StatelessWidget {
  final String imageAssets;
  final String namaHotel;
  final String kota;
  final String rating;
  final VoidCallback gesDec;

  const HotelWidget(
      {Key? key,
      required this.imageAssets,
      required this.namaHotel,
      required this.kota,
      required this.rating,
      required this.gesDec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: gesDec,
      child: Container(
        width: 160,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(imageAssets),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    "$namaHotel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    '$kota',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 27),
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text(
                        '$rating',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
