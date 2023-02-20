import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golocate/back_end/db/db_helper.dart';
import 'package:golocate/back_end/model/ticket.dart';
import 'package:golocate/components/history.dart';
import 'package:golocate/components/my_ticket_page.dart';
import 'package:golocate/go_provider/rating_provider.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  final Ticket data;
  const RatingPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  DBHelper _dbHelper = DBHelper();

  var org = Colors.yellow[700];
  var grr = Colors.green;
  var gry = Colors.grey[300];
  var blk = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var ratePro = Provider.of<RatingProvider>(context);
    var ticPro = Provider.of<TiketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            children: [
              Material(
                elevation: 6,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 400,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            'How would you rate GoLocate?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 5),
                            IconButton(
                                icon: const Icon(Icons.star_rate_rounded,
                                    size: 50),
                                onPressed: () {
                                  ratePro.setStar1 = !ratePro.getStar1;
                                  ratePro.setStar2 = false;
                                  ratePro.setStar3 = false;
                                  ratePro.setStar4 = false;
                                  ratePro.setStar5 = false;
                                  ticPro.setRating = '1';
                                  //ticPro.changeRating(widget.range, "1");
                                },
                                color: ratePro.getStar1 == false ? gry : org),
                            SizedBox(width: 10),
                            IconButton(
                                icon: const Icon(Icons.star_rate_rounded,
                                    size: 50),
                                onPressed: () {
                                  ratePro.setStar1 = true;
                                  ratePro.setStar2 = true;
                                  ratePro.setStar3 = false;
                                  ratePro.setStar4 = false;
                                  ratePro.setStar5 = false;
                                  ticPro.setRating = '2';
                                  //ticPro.changeRating(widget.range, "2");
                                },
                                color: ratePro.getStar2 == false ? gry : org),
                            SizedBox(width: 10),
                            IconButton(
                                icon: const Icon(Icons.star_rate_rounded,
                                    size: 50),
                                onPressed: () {
                                  ratePro.setStar1 = true;
                                  ratePro.setStar2 = true;
                                  ratePro.setStar3 = true;
                                  ratePro.setStar4 = false;
                                  ratePro.setStar5 = false;
                                  ticPro.setRating = '3';
                                  //ticPro.changeRating(widget.range, "3");
                                },
                                color: ratePro.getStar3 == false ? gry : org),
                            SizedBox(width: 10),
                            IconButton(
                                icon: const Icon(Icons.star_rate_rounded,
                                    size: 50),
                                onPressed: () {
                                  ratePro.setStar1 = true;
                                  ratePro.setStar2 = true;
                                  ratePro.setStar3 = true;
                                  ratePro.setStar4 = true;
                                  ratePro.setStar5 = false;
                                  ticPro.setRating = '4';
                                  //ticPro.changeRating(widget.range, "4");
                                },
                                color: ratePro.getStar4 == false ? gry : org),
                            SizedBox(width: 10),
                            IconButton(
                                icon: const Icon(Icons.star_rate_rounded,
                                    size: 50),
                                onPressed: () {
                                  ratePro.setStar1 = true;
                                  ratePro.setStar2 = true;
                                  ratePro.setStar3 = true;
                                  ratePro.setStar4 = true;
                                  ratePro.setStar5 = true;
                                  ticPro.setRating = '5';
                                  //ticPro.changeRating(widget.range, "5");
                                },
                                color: ratePro.getStar5 == false ? gry : org),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 5),
                        width: 300,
                        child: Text(
                            'Tap the number of stars you would give us on a scale from 1-5.',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Row(
                    children: [
                      Text('First Impression', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 45),
                      IconButton(
                          icon: Icon(Icons.thumb_up, size: 25),
                          onPressed: () {
                            ratePro.setThumb1 = !ratePro.getThumb1;
                            ratePro.setThumb2 = false;
                          },
                          color: ratePro.getThumb1 == false ? blk : grr),
                      IconButton(
                          icon: Icon(Icons.thumb_down, size: 25),
                          onPressed: () {
                            ratePro.setThumb1 = false;
                            ratePro.setThumb2 = !ratePro.getThumb2;
                          },
                          color: ratePro.getThumb2 == false ? blk : grr),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: 500,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text('Ease of booking', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 45),
                      IconButton(
                          icon: Icon(Icons.thumb_up, size: 25),
                          onPressed: () {
                            ratePro.setThumb3 = !ratePro.getThumb3;
                            ratePro.setThumb4 = false;
                          },
                          color: ratePro.getThumb3 == false ? blk : grr),
                      IconButton(
                          icon: Icon(Icons.thumb_down, size: 25),
                          onPressed: () {
                            ratePro.setThumb3 = false;
                            ratePro.setThumb4 = !ratePro.getThumb4;
                          },
                          color: ratePro.getThumb4 == false ? blk : grr),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: 500,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text('Ease of Aplication',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(width: 32),
                      IconButton(
                          icon: Icon(Icons.thumb_up, size: 25),
                          onPressed: () {
                            ratePro.setThumb5 = !ratePro.getThumb5;
                            ratePro.setThumb6 = false;
                          },
                          color: ratePro.getThumb5 == false ? blk : grr),
                      IconButton(
                          icon: Icon(Icons.thumb_down, size: 25),
                          onPressed: () {
                            ratePro.setThumb5 = false;
                            ratePro.setThumb6 = !ratePro.getThumb6;
                          },
                          color: ratePro.getThumb6 == false ? blk : grr),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: 500,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text('Hotel quality', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 72),
                      IconButton(
                          icon: Icon(Icons.thumb_up, size: 25),
                          onPressed: () {
                            ratePro.setThumb7 = !ratePro.getThumb7;
                            ratePro.setThumb8 = false;
                          },
                          color: ratePro.getThumb7 == false ? blk : grr),
                      IconButton(
                          icon: Icon(Icons.thumb_down, size: 25),
                          onPressed: () {
                            ratePro.setThumb7 = false;
                            ratePro.setThumb8 = !ratePro.getThumb8;
                          },
                          color: ratePro.getThumb8 == false ? blk : grr),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: 500,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text('Customer Service', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 38),
                      IconButton(
                          icon: Icon(Icons.thumb_up, size: 25),
                          onPressed: () {
                            ratePro.setThumb9 = !ratePro.getThumb9;
                            ratePro.setThumb10 = false;
                          },
                          color: ratePro.getThumb9 == false ? blk : grr),
                      IconButton(
                          icon: Icon(Icons.thumb_down, size: 25),
                          onPressed: () {
                            ratePro.setThumb9 = false;
                            ratePro.setThumb10 = !ratePro.getThumb10;
                          },
                          color: ratePro.getThumb10 == false ? blk : grr),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    width: 300,
                    child: const TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          border: OutlineInputBorder(),
                          hintText: 'Add a note',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 460,
                    height: 70,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[600]),
                        onPressed: () async {
                          addData(ticPro.getRating);
                          await _dbHelper.updateTicket(Ticket.fromMap({
                            'id': widget.data.id,
                            'user_id': widget.data.userID,
                            'namaHotel': widget.data.namaHotel,
                            'kota': widget.data.kota,
                            'price': widget.data.price,
                            'checkIn': widget.data.checkIn,
                            'checkOut': widget.data.checkOut,
                            'rating': ticPro.getRating,
                            'status': '1'
                          }));
                          ratePro.setStar1 = false;
                          ratePro.setStar2 = false;
                          ratePro.setStar3 = false;
                          ratePro.setStar4 = false;
                          ratePro.setStar5 = false;
                          ticPro.setRating = '';
                          //ticPro.changeStatus(widget.range, '1');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyTicketPage()));
                        },
                        child: Text('Submit',
                            style:
                                TextStyle(fontSize: 24, color: Colors.white))),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addData(String getRating) async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    HistoryModel InsertData = HistoryModel(
        userID: widget.data.userID,
        namaHotel: widget.data.namaHotel,
        kota: widget.data.kota,
        price: widget.data.price,
        checkIn: widget.data.checkIn,
        checkOut: widget.data.checkOut,
        rating: getRating,
        status: widget.data.status);
    await db.collection("ticket_history").add(InsertData.toMap());
  }
}
