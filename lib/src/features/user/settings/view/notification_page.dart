// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/features/user/user_bottom_navigation/view/bottom_navigation_view.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Notifications',
            endWidget: SizedBox(),
            leadingWidget: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
              onTap: () {
                Get.off(const BottomNavigationPage());
              },
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            context: context,
            title: 'Continue Payment',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
            date: '1 May 2021, 10:56 AM',
          ),
          _buildNotificationCard(
            title: 'Greens Briefing: Sanchez Equals Record',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
            date: '6 May 2021, 10:43 AM',
            context: context,
          ),
          _buildNotificationCard(
            context: context,
            title: 'Congratulations',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
            date: '6 hours ago',
          ),
          _buildNotificationCard(
            title: 'Ticket Booked',
            context: context,
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
            date: '21 June 2021, 12:33 AM',
          ),
          _buildNotificationCard(
            context: context,
            title: 'Congratulations',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
            date: '1 hour ago',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String date,
    required context,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:
              BorderSide(color: colorScheme(context).primary.withOpacity(0.2))),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textTheme(context).bodySmall?.copyWith(
                    color: colorScheme(context).primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(description,
                style: textTheme(context).bodySmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 12),
            Text(date,
                style: textTheme(context).bodySmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
