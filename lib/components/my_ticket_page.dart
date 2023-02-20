import 'package:flutter/material.dart';
import 'package:golocate/back_end/db/db_helper.dart';
import 'package:golocate/back_end/model/ticket.dart';
import 'package:golocate/components/history_page.dart';
import 'package:golocate/components/home_page.dart';
import 'package:golocate/components/rating_page.dart';
import 'package:golocate/go_provider/currency_format.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  DBHelper _dbHelper = DBHelper();
  List<Ticket>? tmp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var ticPro = Provider.of<TiketProvider>(context, listen: false);
      var regisPro = Provider.of<RegisterProvider>(context, listen: false);
      var id = int.parse(regisPro.getActiveUser[0]['user_id'].toString());
      _getTicketId(id, ticPro);
    });
  }

  @override
  Widget build(BuildContext context) {
    var ticPro = Provider.of<TiketProvider>(context);
    var regisPro = Provider.of<RegisterProvider>(context);
    _dbHelper.getTicket().then(((value) => ticPro.setTicketList = value));
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const History()));
        }, icon: const Icon(Icons.history))],
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text(
                  'My Ticket',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 700,
                child: ListView.builder(
                    itemCount: ticPro.getTicketList.length,
                    itemBuilder: (context, int i) {
                      Ticket ticket = ticPro.getTicketList[i];
                      if (ticket.userID.toString() ==
                          regisPro.getActiveUser[0]['user_id'].toString() && ticket.status.toString() == "0") {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: Border.all(color: Colors.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ListTile(
                                  title: Text(ticket.namaHotel.toString()),
                                  isThreeLine: true,
                                  subtitle: Text(
                                      '${ticket.kota.toString()}\n${CurrencyFormat.convertToIdr(ticket.price, 0)}'),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(
                                                ticket.checkIn.toString()))
                                            .toString()),
                                        Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(
                                                ticket.checkOut.toString()))
                                            .toString()),
                                        ticket.status == '1'
                                            ? Padding(
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
                                                    Text('${ticket.rating}'),
                                                  ],
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RatingPage(data: ticket,)));
                                                },
                                                child: Text('Rate'))
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
              ),
              /*Container(
                height: 700,
                child: ListView(
                  children: [
                    if (ticPro.getTicketList.isNotEmpty)
                      for (var i = 0; i < ticPro.getTicketList.length; i++)
                        if (regisPro.getActiveUser[0]['user_id'] ==
                            ticPro.getTicketList[i]['user_id'])
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: Border.all(color: Colors.blue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(
                                        ticPro.getTicketList[i]['namaHotel']),
                                    isThreeLine: true,
                                    subtitle: Text(
                                        '${ticPro.getTicketList[i]['kota']}\n${CurrencyFormat.convertToIdr(ticPro.getTicketList[i]['price'], 0)}'),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(DateTime.parse(ticPro
                                                  .getTicketList[i]['checkIn']
                                                  .toString()))
                                              .toString()),
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(DateTime.parse(ticPro
                                                  .getTicketList[i]['checkOut']
                                                  .toString()))
                                              .toString()),
                                          ticPro.getTicketList[i]['status'] ==
                                                  '1'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      Text(
                                                          '${ticPro.getTicketList[i]['rating']}.0'),
                                                    ],
                                                  ),
                                                )
                                              : TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    RatingPage(
                                                                      range: i,
                                                                    )));
                                                  },
                                                  child: Text('Rate'))
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          )
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getTicketId(int id, TiketProvider ticPro) async {
    var list = await _dbHelper.getTicket();
    print(list);
    ticPro.clearTicket();
    list!.forEach((ticket) {
      ticPro.setTicketList = Ticket.fromMap(ticket);
    });
  }
}
