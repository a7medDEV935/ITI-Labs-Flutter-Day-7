import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/welcome_asset.png',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to Our App',
                style: welcomeTextStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Manage your tasks and users effortlessly.',
                style: welcomeSubtitleStyle,
              ),
              const SizedBox(height: 30),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40 , horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppString.createAccount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSecondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Get Started', style: getStartedButtonStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle get welcomeTextStyle {
  return TextStyle(
    color: AppColors.kOnPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get welcomeSubtitleStyle {
  return TextStyle(
    color: AppColors.kOnPrimary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get getStartedButtonStyle {
  return TextStyle(
    color: AppColors.kOnSecondary,
    fontSize: 18,
  );
}
