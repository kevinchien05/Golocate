import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  final String imageAssets;
  final String namaKota;
  final VoidCallback gesDec;
  const CityWidget(
      {Key? key, required this.imageAssets, required this.namaKota, required this.gesDec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: gesDec,
      child: Container(
        width: 160,
        child: Column(
          children: [
            Image.asset(
              imageAssets,
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "$namaKota",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
