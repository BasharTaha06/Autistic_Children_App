import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': '👋 مرحبًا بعودتك!',
      'message': 'سعيدون لرؤيتك مرة أخرى 😊',
    },
    {
      'title': '🩺 تذكير مهم',
      'message': 'لا تنسَ جلسة الطبيب اليوم.',
    },
    {
      'title': '📅 تحقق من الحجز',
      'message': 'هل تأكدت من حجزك مع الطبيب؟',
    },
    {
      'title': '📰 مقالات مفيدة',
      'message': 'هل قرأت المقالات الجديدة؟ ستحبها!',
    },
    {
      'title': '🧠 نشاط تفاعلي مقترح',
      'message': 'جرب تمرين جديد يساعد طفلك على تحسين التواصل البصري 🎯',
    },
  ];

  String getFormattedDateTime() {
    final now = DateTime.now();
    final formattedDate = DateFormat('y/MM/dd – HH:mm').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ListTile(
                trailing: Text(
                  "${index + 1}",
                  style: TextStyle(color: Colors.red),
                ),
                leading: Icon(Icons.notifications_active, color: Colors.orange),
                title: Text(
                  item['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(item['message']!),
                    SizedBox(height: 6),
                    Text(
                      getFormattedDateTime(),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
