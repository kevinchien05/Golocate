import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golocate/components/history.dart';
import 'package:golocate/go_provider/currency_format.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> history = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var regisPro = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text(
                'History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 700,
              child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, position) {
                    if (history[position].userID.toString() ==
                        regisPro.getActiveUser[0]['user_id'].toString()) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: Border.all(color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                title: Text(
                                    history[position].namaHotel.toString()),
                                isThreeLine: true,
                                subtitle: Text(
                                    '${history[position].kota.toString()}\n${CurrencyFormat.convertToIdr(history[position].price, 0)}'),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(
                                              history[position]
                                                  .checkIn
                                                  .toString()))
                                          .toString()),
                                      Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(
                                              history[position]
                                                  .checkOut
                                                  .toString()))
                                          .toString()),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Text('${history[position].rating}'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = await FirebaseFirestore.instance;
    var data = await db.collection('ticket_history').get();
    setState(() {
      history =
          data.docs.map((doc) => HistoryModel.fromDocSnapshot(doc)).toList();
    });
  }
}
