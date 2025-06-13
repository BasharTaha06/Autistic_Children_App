import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsChildPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': '🎉 مرحبًا بعودتك يا بطل!',
      'message': 'نحن فخورون بك! مستعد لبدء يوم جديد؟ 😄',
    },
    {
      'title': '🧩 وقت التمرين',
      'message': 'هيا نلعب لعبة التعرف على الأشكال 🟢🔺🔵',
    },
    {
      'title': '🎵 لحظة استرخاء',
      'message': 'استمع إلى موسيقى هادئة تساعدك على الهدوء 🌈',
    },
    {
      'title': '👀 تحدي جديد!',
      'message': 'هل تستطيع إيجاد صورتين متشابهتين؟ 🖼️✨',
    },
    {
      'title': '📘 قصة قبل النوم',
      'message': 'وقت القصة! افتح القصة المفضلة لديك 📖💤',
    },
    {
      'title': '👏 أحسنت!',
      'message': 'لقد أتممت تمرين اليوم! استمر على هذا الأداء الرائع ⭐',
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
