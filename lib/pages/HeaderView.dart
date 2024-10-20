import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeaderView extends StatelessWidget {
  final bool isLoggedIn;
  final String userName;
  final String userMobile;

  const HeaderView({
    super.key,
    required this.isLoggedIn,
    required this.userName,
    required this.userMobile,
  });

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
            child: isLoggedIn
                ? CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/150', // Replace with user image if available
              placeholder: (context, url) => const CircularProgressIndicator(), // Loading placeholder
              errorWidget: (context, url, error) => const Icon(Icons.error), // Error handling
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 40,
                backgroundImage: imageProvider,
              ),
            )
                : const Icon(
              Icons.person,
              size: 50,
              color: Colors.grey,
            ),
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
                userMobile,
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
