import 'package:autisticchildren/child/Voice/VoiceItem.dart';
import 'package:autisticchildren/child/Voice/voicescreen.dart';
import 'package:flutter/material.dart';

final List<VoiceItem> voiceItems = [
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Apple.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Apple.mp3',
    expectedText: 'تفاحه حمراء',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Cat.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Cat.mp3',
    expectedText: 'قطة',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Dad.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Dad.mp3',
    expectedText: 'أبى',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Dog.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Dog.mp3',
    expectedText: 'هذا كلب بنى كبير',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Milk.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Milk.mp3',
    expectedText: 'اريد حليب',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Mom.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Mom.mp3',
    expectedText: 'أمى',
  ),
  VoiceItem(
    imagePath: 'assets/VoiceData/Voice_Image/Sun.jpg',
    voicePath: 'VoiceData/Voice_Mp3/Sun.mp3',
    expectedText: 'الشمس ساطعه اليوم',
  ),
];

class VoiceGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              alignment: Alignment.centerRight,
              child: Text("اختار تمرين التواصل"))),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: voiceItems.length,
        itemBuilder: (context, index) {
          final item = voiceItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoiceScreen(item: item)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(item.imagePath),
            ),
          );
        },
      ),
    );
  }
}
