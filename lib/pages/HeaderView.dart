import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  final bool isLoggedIn;
  final String userName;
  final String userEmail;

  const HeaderView({
    Key? key,
    required this.isLoggedIn,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.purple[700], // Background color or gradient
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            backgroundImage: isLoggedIn
                ? const NetworkImage(
              'https://via.placeholder.com/150', // Replace with user image if available
            )
                : null,
            child: !isLoggedIn
                ? const Icon(
              Icons.person,
              size: 50,
              color: Colors.grey,
            )
                : null,
          ),
          const SizedBox(height: 10),
          isLoggedIn
              ? Column(
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                userEmail,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          )
              : const Text(
            'Welcome Guest',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
