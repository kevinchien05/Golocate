import 'package:flutter/material.dart';
import 'package:golocate/back_end/helper/http_helper.dart';
import 'package:golocate/back_end/model/hotel.dart';
import 'package:golocate/components/hotel_detail_page.dart';
import 'package:golocate/components/voucher_page.dart';
import 'package:golocate/components/widget/city_widget.dart';
import 'package:golocate/components/widget/hotel_widget.dart';
import 'package:golocate/go_provider/home_provider.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List? hotels;
  dynamic tmp;
  Future<dynamic>? dta;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homePro = Provider.of<HomeProvider>(context);
    var regisPro = Provider.of<RegisterProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.paid),
                          SizedBox(
                            width: 20,
                          ),
                          Text('${regisPro.getActiveUser[0]['point']} Points')
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.loyalty),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VoucherPage()));
                              },
                              child: const Text(
                                'My Voucher',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recommended Hotel'),
                TextButton(
                    onPressed: () {
                      homePro.setCurrent(1);
                    },
                    child: Text('View All'))
              ],
            ),
            Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (hotels?.length == null) ? 0 : hotels?.length,
                    itemBuilder: (context, int i) {
                      return HotelWidget(
                          imageAssets: hotels![i].gambar,
                          namaHotel: hotels![i].nama,
                          kota: hotels![i].kota,
                          rating: hotels![i].rating.toString(),
                          gesDec: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotelDetail(
                                          data: hotels![i],
                                        )));
                          });
                    })),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('Explore City'),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                for (var i = 0; i < homePro.getListKota.length; i++)
                  CityWidget(
                    imageAssets: homePro.getListKota[i]['gambar'],
                    namaKota: homePro.getListKota[i]['namaKota'],
                    gesDec: () {
                      homePro.setNamaKota(homePro.getListKota[i]['namaKota'].toString());
                      homePro.setIsKota = true;
                      homePro.setCurrent(1);
                    },
                  )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future initialize() async {
    hotels = await helper?.getHotels();
    setState(() {
      hotels = hotels;
    });
  }
}
