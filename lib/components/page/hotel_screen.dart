import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golocate/back_end/helper/http_helper.dart';
import 'package:golocate/components/hotel_detail_page.dart';
import 'package:golocate/go_provider/currency_format.dart';
import 'package:golocate/go_provider/home_provider.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:provider/provider.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  HttpHelper? helper;
  List? hotels;
  bool found = true;
  dynamic tmp;
  List? dta;
  dynamic dtaKota;

  final StreamController<String> _searchController = StreamController<String>();
  final StreamController<String> _kotaController = StreamController<String>();

  Widget _HotelList(dynamic Pic, String Hotelname, String HotelPlace,
      String HotelStars, String HotelPrice, VoidCallback gesDec) {
    var _width = MediaQuery.of(context).size.width;
    var _heigth = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade500, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.only(right: 5, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: gesDec,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 125,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(Pic), fit: BoxFit.cover)),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Hotelname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.035)),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(HotelPlace,
                              style: const TextStyle(color: Colors.grey)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.star,
                                    size: _width * 0.035,
                                    color: Colors.orange[400]),
                                Text(HotelStars,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: _width * 0.035)),
                                SizedBox(
                                  width: 10,
                                )
                              ]),
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                          CurrencyFormat.convertToIdr(int.parse(HotelPrice), 0),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width * 0.025)),
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    helper = HttpHelper();
    dta = [];
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homePro = Provider.of<HomeProvider>(context);
    var ticPro = Provider.of<TiketProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Container(
          child: TextField(
            controller: homePro.getHomeSearch,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              border: OutlineInputBorder(),
              hintText: 'Where are you going ?',
              prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      dta = [];
                    });
                    homePro.setIsKota = false;
                    _searchController.add(homePro.getHomeSearch.text);
                  },
                  icon: const Icon(Icons.search)),
            ),
          ),
        ),
        Container(
          child: homePro.getIsKota
              ? FutureBuilder(
                  future: helper?.getHotels1(),
                  builder: (context, snapshot) {
                    dtaKota = snapshot.data;
                    return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.8),
                                    itemCount: dtaKota.length,
                            itemBuilder: (context,int i){
                              return Text(dtaKota[i]['kota'].toString());
                            }));
                  })
              : StreamBuilder(
                  initialData: '',
                  stream: _searchController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data.toString() == '') {
                      return Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 0.8),
                              itemCount:
                                  (hotels?.length == null) ? 0 : hotels!.length,
                              itemBuilder: (context, int i) {
                                return _HotelList(
                                    hotels![i].gambar.toString(),
                                    hotels![i].nama,
                                    hotels![i].kota,
                                    hotels![i].rating.toString(),
                                    hotels![i].harga.toString(), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HotelDetail(data: hotels![i])));
                                });
                              }));
                    } else {
                      for (var i = 0; i < hotels!.length; i++) {
                        if (hotels![i]
                            .nama
                            .toString()
                            .toLowerCase()
                            .contains(snapshot.data.toString().toLowerCase())) {
                          dta!.add(hotels![i]);
                        }
                      }
                      return Expanded(
                          child: dta!.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.error_outline,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'Oops, we do not have what \n you are looking for. \n Try a different keyword',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.8),
                                  itemCount:
                                      (dta?.length == null) ? 0 : dta!.length,
                                  itemBuilder: (context, int i) {
                                    return _HotelList(
                                        dta![i].gambar.toString(),
                                        dta![i].nama,
                                        dta![i].kota,
                                        dta![i].rating.toString(),
                                        dta![i].harga.toString(), () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HotelDetail(data: dta![i])));
                                    });
                                  }));
                    }
                  },
                ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    _searchController.close();
    _kotaController.close();
    super.dispose();
  }

  Future initialize() async {
    hotels = await helper?.getHotels();
    setState(() {
      hotels = hotels;
    });
  }
}
