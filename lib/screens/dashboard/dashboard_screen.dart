// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/noti_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_screen.dart';
import 'package:flutter_scale/themes/color.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // share_pref

  late SharedPreferences sharedPreferences;

  String? _fullName, _userName, _avatar, _userStatus;

  // index list of bottomnav
  int _currentIndex = 0;
  String _title = "DashBoard";
  //var List store for page
  final List<Widget> _pageIndicator = [
    HomeScreen(),
    ReportScreen(),
    ProfileScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  void onTabChange(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = "Home Screen";
          break;
        case 1:
          _title = "Report Screen";
          break;
        case 2:
          _title = "Profile Screen";
          break;
        case 3:
          _title = "Notification Screen";
          break;
        case 4:
          _title = "Setting Screen";
          break;
      }
    });
  }

  // create func for read result data from profile

  readUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _fullName = sharedPreferences.getString("fullName");
      _userName = sharedPreferences.getString("userName");
      _avatar = sharedPreferences.getString("imgProfile");
      _userStatus = sharedPreferences.getString("userStatus");
    });
  }

  // call function intial method
  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SafeArea(
        child: _pageIndicator[_currentIndex],
      ),
      drawer: Drawer(
        backgroundColor: primary_dark,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_fullName ?? "..."),
              accountEmail: Text(_userName ?? "..."),
              currentAccountPicture: _avatar != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundColor: primary,
                      backgroundImage: NetworkImage("${baseImageUrl}profile/${_avatar!}"),
                    )
                  : CircularProgressIndicator(),
            ),
            ListTile(
              leading: Icon(Icons.person, color: icons),
              title: Text("About us"),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: icons),
              title: Text("info"),
              onTap: () {
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page, color: icons),
              title: Text("Contact"),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: icons),
              title: Text("log out"),
              onTap: () {
                logOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChange,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: "Report",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
