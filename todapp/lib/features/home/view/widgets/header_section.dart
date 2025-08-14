import 'package:flutter/material.dart';
import 'package:todapp/core/utils/app_assets.dart';
import '../../../profile/view/ProfilePage.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String? password;

  const HeaderSection({super.key, required this.name, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profilepage(
                    name: name,
                    password: password,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(AppAssets.flag),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hello!", style: TextStyle(fontSize: 16)),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
