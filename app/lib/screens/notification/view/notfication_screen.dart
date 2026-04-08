import 'package:app/screens/notification/model/notificatation_model.dart';
import 'package:app/screens/notification/viewmodel/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<NotificationProvider>().getNotification(),
    );

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),

      body: Consumer<NotificationProvider>(
        builder: (_, provider, __) {
          /// LOADING
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.grey,));
          }

          /// EMPTY
          if (provider.list.isEmpty) {
            return const Center(child: Text("No Notifications"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.getNotification();
            },

            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.list.length,
              itemBuilder: (_, index) {
                final notification = provider.list[index];

                return NotificationTile(notification: notification);
              },
            ),
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.05)),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: const Icon(Icons.notifications),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  notification.description,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 8),

                Text(
                  _formatDate(notification.createdAt),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          /// UNREAD DOT
          if (!notification.isRead)
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }
}
