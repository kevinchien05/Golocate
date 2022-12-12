import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golocate/components/login_page.dart';
import 'package:golocate/components/my_ticket_page.dart';
import 'package:golocate/components/voucher_page.dart';
import 'package:golocate/go_provider/home_provider.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var regisPro = Provider.of<RegisterProvider>(context);
    var homePro = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: homePro.getCurrent == 2
          ? AppBar(
              elevation: 0,
              title: const Text('Profile'),
              centerTitle: true,
              leading: const Icon(
                Icons.abc,
                color: Colors.transparent,
              ),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: Builder(
                  builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color:Colors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      })),
              actions: [
                CircleAvatar(
                  child: Text(regisPro.getActiveUser[0]['username']
                      .toString()
                      .substring(0, 1)
                      .toUpperCase()),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
      body: homePro.getListPage[homePro.getCurrent],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    child: Text(regisPro.getActiveUser[0]['username']
                        .toString()
                        .substring(0, 1)
                        .toUpperCase())),
                accountName:
                    Text(regisPro.getActiveUser[0]['username'].toString()),
                accountEmail:
                    Text(regisPro.getActiveUser[0]['email'].toString())),
            _drawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
                homePro.setCurrent(0);
                homePro.getHomeSearch.text = '';
              },
            ),
            _drawerItem(
              icon: Icons.hotel,
              text: 'Hotel',
              onTap: () {
                Navigator.pop(context);
                homePro.setFound = true;
                homePro.setCurrent(1);
              },
            ),
            _drawerItem(
              icon: Icons.confirmation_num,
              text: 'My Ticket',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyTicketPage()));
              },
            ),
            _drawerItem(
              icon: Icons.loyalty,
              text: 'My Voucher',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VoucherPage()));
              },
            ),
            Divider(),
            _drawerItem(
              icon: Icons.account_circle,
              text: 'My Profile',
              onTap: () {
                Navigator.pop(context);
                homePro.setCurrent(2);
              },
            ),
            _drawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                regisPro.setLoginEmail = false;
                regisPro.setLoginPass = false;
                regisPro.setLoginRight = false;
                regisPro.setLoginPassRight = false;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: homePro.getCurrent,
          onTap: (val) {
            homePro.setCurrent(val);
            homePro.setFound = true;
            homePro.getHomeSearch.text = '';
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.hotel), label: 'Hotel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ]),
    );
  }
}

Widget _drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
