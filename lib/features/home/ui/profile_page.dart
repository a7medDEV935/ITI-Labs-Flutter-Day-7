import 'package:flutter/material.dart';
import 'package:fourth_day/core/db/shared_preference_db.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _email;
  String? _job;
  String? _gender;
  String? _address;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final first = await SharedPreferenceDB.getString("first_name");
    final last = await SharedPreferenceDB.getString("last_name");
    final email = await SharedPreferenceDB.getString("email");
    final job = await SharedPreferenceDB.getString("job");
    final gender = await SharedPreferenceDB.getString("gender");
    final address = await SharedPreferenceDB.getString("address");
    setState(() {
      _name = "$first $last";
      _email = email;
      _job = job;
      _gender = gender;
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile avatar
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 10),
            Text(
              _name ?? 'Guest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Member since 2021',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            // Account section
            sectionTitle("Account"),
            accountTile(Icons.sms, "Email", _email ?? "N/A"),
            accountTile(Icons.work, "Job", _job ?? "N/A"),
            accountTile(Icons.person, "Gender", _gender ?? "N/A"),
            accountTile(Icons.location_on, "Address", _address ?? "N/A"),
            const SizedBox(height: 30),
            sectionTitle("Completed Tasks"),
            completedTaskTile("Grocery Shopping"),
            completedTaskTile("Pay Bills"),
            completedTaskTile("Book Appointment"),
          ],
        ),
      );
  }

  Widget sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accountTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

  Widget completedTaskTile(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 22),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
