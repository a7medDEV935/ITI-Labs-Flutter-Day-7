import 'package:flutter/material.dart';
import 'package:fourth_day/features/home/ui/widgets/drawer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/db/shared_preference_db.dart';
import '../../posts/ui/posts_page.dart';
import 'profile_page.dart';
import 'tasks_page.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  Future<void> fetchUserName() async {
    userName =
        "${await SharedPreferenceDB.getString("first_name")} ${await SharedPreferenceDB.getString("last_name")}";
    setState(() {});
  }

  List<Widget> get _screens => [
        HomeWidget(name: userName),
        TasksPage(),
        ProfilePage(),
        PostsPage(),
      ];

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.kPrimary,
        iconTheme: IconThemeData(color: AppColors.kOnPrimary),
      ),
      drawer: CustomDrawer(
        onTap: (index) {
          Navigator.pop(context);
          _onItemTapped(index);
        },
      ),
      backgroundColor: AppColors.kPrimary,
      body: _screens[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _selectedIndex > 2 ? 0 : _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
