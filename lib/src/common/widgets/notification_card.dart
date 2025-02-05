import 'package:flutter/material.dart';

class PredictionCard extends StatelessWidget {
  final PredictionItem notification;

  const PredictionCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.grey[100]
            : Colors.green[50], // Background color for read/unread
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: notification.isRead ? Colors.grey : Colors.green,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: notification.isRead ? Colors.black : Colors.green,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            notification.description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            notification.date,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class PredictionItem {
  final String title;
  final String description;
  final String date;
  final bool isRead;

  PredictionItem({
    required this.title,
    required this.description,
    required this.date,
    required this.isRead,
  });
}
