import 'package:flutter/material.dart';
import 'package:golocate/components/payment_page.dart';
import 'package:golocate/go_provider/currency_format.dart';
import 'package:golocate/go_provider/home_provider.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

class HotelDetail extends StatefulWidget {
  final dynamic data;
  const HotelDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  Widget _offers(dynamic the_icons, String icons_name) {
    return Container(
      margin: EdgeInsets.all(15),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              the_icons,
              size: 40,
              color: Colors.grey[700],
            ),
            Text(icons_name,
                style: TextStyle(color: Colors.grey[700], fontSize: 16))
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var hotels = Provider.of<RegisterProvider>(context);
    var homePro = Provider.of<HomeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 25, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.data.gambar,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.only(top: 4),
              width: 200,
              height: 8,
              alignment: Alignment.center,
            ),
            Container(
              width: _width,
              height: 740,
              child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data.nama,
                            style: const TextStyle(fontSize: 32)),
                        Row(
                          children: [
                            Text(widget.data.tamu.toString() + ' guests',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(widget.data.kasur.toString() + ' bed',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                  widget.data.mandi.toString() + ' bathroom',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(children: [
                              Icon(Icons.star,
                                  color: Colors.orange[400], size: 35),
                                  const SizedBox(width: 5,),
                              Text(widget.data.rating.toString(), style: TextStyle(fontSize: 25),)
                            ])),
                        Text(widget.data.kota,
                            style: const TextStyle(color: Colors.grey)),
                        Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            width: _width,
                            height: 120,
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.only(top: 25, bottom: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 20),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(widget.data.harga
                                                    .toString()),
                                                0),
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold))),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 10),
                                      child: TextButton(
                                        child: const Text(
                                          'LOOK INSIDE',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Theme.of(context).colorScheme.primary)))),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 20),
                                    alignment: Alignment.topLeft,
                                    child:  Text('a room for a day',
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary))),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 40, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('What this place offers',
                                  style: TextStyle(fontSize: 20)),
                              Container(
                                padding: EdgeInsets.only(left: 32),
                                child: TextButton(
                                    child: const Text('More',
                                        style: TextStyle(color: Colors.blue)),
                                    onPressed: () {}),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                _offers(Icons.wifi, 'Wifi'),
                                _offers(Icons.bathtub_rounded, 'SPA'),
                                _offers(Icons.pool, 'Swim Pool'),
                                _offers(Icons.dining_rounded, 'Breakfast'),
                                _offers(Icons.golf_course_rounded, 'Golf'),
                              ])),
                        ),
                        const Text('Description',
                            style: TextStyle(fontSize: 20)),
                        Container(
                          alignment: Alignment.topLeft,
                          width: _width,
                          child: Text(
                            widget.data.des,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          width: _width,
                          height: 50,
                          margin: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Payment(data: widget.data,
                                          )));
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                            child: const Text('Book Now !',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ])),
            )
          ],
        ),
      ),
    );
  }
}
