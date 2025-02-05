import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final bool isOnline;

  const UserProfileCard({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.isOnline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(imageUrl)),
                        border: Border.all(color: Color(0xffE6F8FF), width: 3)),
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColor.appGreenColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.more_vert,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
