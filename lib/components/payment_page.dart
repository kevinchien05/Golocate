import 'package:flutter/material.dart';
import 'package:golocate/back_end/db/db_helper.dart';
import 'package:golocate/back_end/model/ticket.dart';
import 'package:golocate/back_end/model/user.dart';
import 'package:golocate/components/my_ticket_page.dart';
import 'package:golocate/components/voucher_page.dart';
import 'package:golocate/go_provider/currency_format.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  final dynamic data;

  const Payment({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DBHelper _dbHelper = DBHelper();
  int id = 0;

  @override
  Widget build(BuildContext context) {
    var ticPro = Provider.of<TiketProvider>(context);
    var regisPro = Provider.of<RegisterProvider>(context);
    var _diffDate =
        ticPro.getCheckDate.end.difference(ticPro.getCheckDate.start).inDays;
    var _temp = int.parse(widget.data.harga.toString()) * _diffDate;
    var _total = _temp + 30000;
    var _point = (_total * 0.01).toInt();
    DateTime? _dateTime = DateTime.now();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
                        'Summary',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(widget.data.gambar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.nama,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange[400], size: 20),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.data.rating.toString(),
                                    style: TextStyle(fontSize: 25),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.data.kota,
                                    style: TextStyle(color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${widget.data.nama.substring(6)}@gmail.com',
                                    style: TextStyle(color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '08137525012',
                                    style: TextStyle(color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Check-in'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(DateFormat('dd/MM/yyyy')
                                        .format(ticPro.getCheckDate.start)
                                        .toString()),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Check-out'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(DateFormat('dd/MM/yyyy')
                                        .format(ticPro.getCheckDate.end)
                                        .toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                  minimumSize: const Size(400, 50)),
                              child: const Text('Change Date'),
                              onPressed: () {
                                _myDateRangePicker(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // Detail room
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Container(
                      child: const Text(
                        'Room',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Price'),
                        Text(CurrencyFormat.convertToIdr(
                            int.parse(widget.data.harga.toString()), 0))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Container(
                      child: const Text(
                        'Payment Summary',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Room x ${_diffDate.toString()}'),
                        Text(CurrencyFormat.convertToIdr(_temp, 0))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Administration fee'),
                        Text(CurrencyFormat.convertToIdr(30000, 0))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text(ticPro.getSwitch == true
                            ? CurrencyFormat.convertToIdr(ticPro.getTotal, 0)
                            : CurrencyFormat.convertToIdr(_total, 0))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Points'),
                        Text(ticPro.getSwitch == true
                            ? '+ ${ticPro.getPoint}'
                            : '+ ${_point.toString()}')
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Use Point'),
                        Switch(
                            value: ticPro.getSwitch,
                            onChanged: int.parse(regisPro.getActiveUser[0]
                                            ['point']
                                        .toString()) >
                                    0
                                ? (val) {
                                    ticPro.setSwitch = val;
                                    ticPro.setTotal = _total -
                                        int.parse(regisPro.getActiveUser[0]
                                                ['point']
                                            .toString());
                                    ticPro.setPoint = 0;
                                  }
                                : (val) {
                                    ticPro.setSwitch = false;
                                  })
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.paid),
                        const SizedBox(
                          width: 30,
                        ),
                        Text('${regisPro.getActiveUser[0]['point']} Point')
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.loyalty),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VoucherPage()));
                            },
                            child: ticPro.getVoucherActive.isNotEmpty
                                ? Text(
                                    ticPro.getVoucherActive[0]['nama'],
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    'Use Voucher',
                                    style: TextStyle(color: Colors.black),
                                  ))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    'Order',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_diffDate > 0) {
                      ticPro.setCheckDate = DateTimeRange(
                          start: DateTime.now(),
                          end: DateTime.now().add(Duration(days: 1)));
                      await _dbHelper.insertTicket(Ticket(
                        userID: int.parse(regisPro.getActiveUser[0]['user_id'].toString()),
                        namaHotel: widget.data.nama,
                        kota: widget.data.kota,
                        price: _total,
                        checkIn: ticPro.getCheckDate.start.toString(),
                        checkOut: ticPro.getCheckDate.end.toString(),
                        rating: '0',
                        status: '0'
                      ));
                      /*ticPro.setTicketList = {
                        'user_id': regisPro.getActiveUser[0]['user_id'],
                        'gambar': widget.data.gambar,
                        'namaHotel': widget.data.nama,
                        'kota': widget.data.kota,
                        'price': _total,
                        'checkIn': ticPro.getCheckDate.start,
                        'checkOut': ticPro.getCheckDate.end,
                        'rating': '0',
                        'status': '0',
                      };*/
                      for (var i = 0; i < regisPro.getUserList.length; i++) {
                        if (regisPro.getActiveUser[0]['user_id'] ==
                            regisPro.getActiveUser[0]['user_id']) {
                          if (ticPro.getSwitch == true) {
                            regisPro.changePoint(0);
                            regisPro.userPoint(i, 0);
                          } else {
                            regisPro.changePoint(_point);
                            regisPro.userPoint(i, _point);
                          }
                        }
                      }
                      ticPro.setSwitch = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTicketPage()));
                    }
                  },
                  style: ButtonStyle(
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _myDateRangePicker(BuildContext context) async {
    final selectedRange = await showDateRangePicker(
        context: context,
        initialDateRange:
            Provider.of<TiketProvider>(context, listen: false).getCheckDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 60)));
    if (selectedRange != null) {
      Provider.of<TiketProvider>(context, listen: false).setCheckDate =
          selectedRange;
    }
  }
}
