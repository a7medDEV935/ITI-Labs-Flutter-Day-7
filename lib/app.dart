import 'package:flutter/material.dart';
import 'package:fourth_day/features/posts/ui/favourite_posts.dart';

import 'core/constants/app_string.dart';
import 'core/db/shared_preference_db.dart';
import 'features/account/ui/account_page.dart';
import 'features/home/ui/home_page.dart';
import 'features/welcome/ui/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute:
              SharedPreferenceDB.getString("first_name") != null &&
              SharedPreferenceDB.getString("last_name") != null &&
              SharedPreferenceDB.getString("email") != null &&
              SharedPreferenceDB.getString("job") != null &&
              SharedPreferenceDB.getString("address") != null &&
              SharedPreferenceDB.getString("gender") != null
          ? AppString.home
          : AppString.welcome,
      routes: {
        AppString.welcome: (context) => const WelcomePage(),
        AppString.createAccount: (context) => const AccountPage(),
        AppString.home: (context) => const HomePage(),
        AppString.favouritePosts: (context) => FavouritePosts(),
      },
    );
  }
}
