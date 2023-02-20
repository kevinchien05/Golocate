import 'package:flutter/material.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:provider/provider.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  Widget _VoucherList(dynamic promo, String voucherName, String valid,
      VoidCallback _tapped, dynamic isi) {
    return Column(
      children: [
        Container(
          height: 150,
          child: ClipRect(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(promo, size: 45, color: Colors.green.shade500),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 30),
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Limited Offer',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      background: Paint()
                                        ..color = const Color.fromARGB(
                                            255, 252, 240, 242)
                                        ..strokeWidth = 18
                                        ..strokeJoin = StrokeJoin.round
                                        ..strokeCap = StrokeCap.round
                                        ..style = PaintingStyle.stroke,
                                      color: Colors.green),
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                voucherName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Valid till ${valid}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0, top: 50),
                      child: TextButton(
                        onPressed: _tapped,
                        child: isi,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 15,
          color: Colors.grey[200],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var ticPro = Provider.of<TiketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Vouchers',
            style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, size: 25)),
        bottom: PreferredSize(
          preferredSize: const Size(0, 70),
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: 455,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[150],
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: ' Enter promo code here',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              for (var i = 0; i < ticPro.getVoucherList.length; i++)
                _VoucherList(
                    ticPro.getVoucherList[i]['icon'],
                    ticPro.getVoucherList[i]['nama'],
                    ticPro.getVoucherList[i]['valid'], () {
                  ticPro.removeVoucher();
                  if (ticPro.getVoucherList[i]['status'] == '0') {
                    ticPro.setVoucherActive = ticPro.getVoucherList[i];
                    ticPro.changeVoucher(i, '1');
                    Navigator.pop(context);
                  } else {
                    ticPro.removeVoucher();
                    ticPro.changeVoucher(i, '0');
                  }
                },
                    ticPro.getVoucherList[i]['status'] == '0'
                        ? Text(
                            'Use Now',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue[400],
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Remove',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold),
                          )),
            ],
          ),
        ),
      ),
    );
  }
}
