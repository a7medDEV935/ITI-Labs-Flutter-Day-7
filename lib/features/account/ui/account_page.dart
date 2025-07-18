import 'package:flutter/material.dart';
import 'package:fourth_day/core/db/shared_preference_db.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _job = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _job.dispose();
    _address.dispose();
  }

  void _clearAllTextFields() {
    _firstName.clear();
    _lastName.clear();
    _email.clear();
    _job.clear();
    _address.clear();
    _gender.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        iconTheme: IconThemeData(color: AppColors.kOnPrimary),
        title: const Text(
          'Account Details',
          style: TextStyle(color: AppColors.kOnPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _customTextField(
              label: 'First Name',
              controller: _firstName,
              iconData: Icons.person,
              keyboardType: TextInputType.name,
            ),
            _customTextField(
              label: 'Last Name',
              controller: _lastName,
              iconData: Icons.person,
              keyboardType: TextInputType.name,
            ),
            _customTextField(
              label: 'Email',
              controller: _email,
              iconData: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            _customTextField(
              label: 'Job Title',
              controller: _job,
              iconData: Icons.work,
              keyboardType: TextInputType.text,
            ),
            _customTextField(
              label: 'Address',
              controller: _address,
              iconData: Icons.location_on,
              keyboardType: TextInputType.streetAddress,
            ),
            _customDropMenu(
              items: ["Male", "Female"],
              onChanged: (String? newValue) async {
                if (newValue == null) return;
                _gender.text = newValue;
                await SharedPreferenceDB.setData("gender", newValue);
              },
            ),
            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await SharedPreferenceDB.setData(
                        "first_name", _firstName.text);
                    await SharedPreferenceDB.setData(
                        "last_name", _lastName.text);
                    await SharedPreferenceDB.setData("email", _email.text);
                    await SharedPreferenceDB.setData("job", _job.text);
                    await SharedPreferenceDB.setData("address", _address.text);
                    if (context.mounted) {
                      if (_firstName.text.isEmpty ||
                          _lastName.text.isEmpty ||
                          _email.text.isEmpty ||
                          _job.text.isEmpty ||
                          _address.text.isEmpty ||
                          _gender.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Account saved successfully')),
                        );
                        _clearAllTextFields();
                        Navigator.pushNamedAndRemoveUntil(context, AppString.home , (route) => false);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kSecondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Save Account', style: getStartedButtonStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customTextField({
  required String label,
  required TextEditingController controller,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
  IconData? iconData,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: AppColors.kBackground,
        suffixIcon: iconData != null
            ? Icon(iconData, color: AppColors.kOnSecondary)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

_customDropMenu({
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Gender',
        filled: true,
        fillColor: AppColors.kBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: Colors.black)),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

TextStyle get getStartedButtonStyle {
  return TextStyle(
    color: AppColors.kOnSecondary,
    fontSize: 18,
  );
}
