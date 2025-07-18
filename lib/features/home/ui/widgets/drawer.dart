import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_string.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onTap});
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.kPrimary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: AppColors.kOnPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.kOnPrimary),
            title: Text('Home', style: TextStyle(color: AppColors.kOnPrimary)),
            onTap: () => onTap!(0),
          ),
          ListTile(
            leading: Icon(Icons.task, color: AppColors.kOnPrimary),
            title: Text('Tasks', style: TextStyle(color: AppColors.kOnPrimary)),
            onTap: () => onTap!(1),
          ),
          ListTile(
            leading: Icon(Icons.person, color: AppColors.kOnPrimary),
            title:
                Text('Profile', style: TextStyle(color: AppColors.kOnPrimary)),
            onTap: () => onTap!(2),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.kOnPrimary),
            title:
                Text('Log out', style: TextStyle(color: AppColors.kOnPrimary)),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, AppString.welcome, (route) => false),
          ),
        ],
      ),
    );
  }
}
