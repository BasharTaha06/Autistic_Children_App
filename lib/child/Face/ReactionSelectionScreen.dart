import 'package:autisticchildren/child/Face/CameraComparisonScreen.dart';
import 'package:autisticchildren/child/Face/reactii_model.dart';
import 'package:flutter/material.dart';

class ReactionSelectionScreen extends StatelessWidget {
  ReactionSelectionScreen({super.key});

  final List<Reaction> reactions = [
    Reaction(
      name: 'سعيد',
      assetPath: 'assets/reactions/happy.jpg',
      keyPoints: const {
        'mouthWidth': 100.0,
        'eyebrowTension': 5.0,
        'eyeOpenness': 0.8,
        'smileProbability': 0.9,
      },
    ),
    Reaction(
      name: 'حزين',
      assetPath: 'assets/reactions/sad.jpg',
      keyPoints: const {
        'mouthWidth': 80.0,
        'eyebrowTension': 15.0,
        'eyeOpenness': 0.6,
        'smileProbability': 0.1,
      },
    ),
    Reaction(
      name: 'غاضب',
      assetPath: 'assets/reactions/angry.jpg',
      keyPoints: const {
        'mouthWidth': 90.0,
        'eyebrowTension': 25.0,
        'eyeOpenness': 0.9,
        'smileProbability': 0.1,
      },
    ),
    Reaction(
      name: 'متحمس',
      assetPath: 'assets/reactions/excited.jpg',
      keyPoints: const {
        'mouthWidth': 120.0,
        'eyebrowTension': 0.0,
        'eyeOpenness': 1.0,
        'smileProbability': 0.3,
      },
    ),
    Reaction(
      name: 'غاضبه',
      assetPath: 'assets/reactions/grumpy.jpg',
      keyPoints: const {
        'mouthWidth': 95.0,
        'eyebrowTension': 10.0,
        'eyeOpenness': 0.7,
        'smileProbability': 0.5,
      },
    ),
    Reaction(
      name: 'خائب الأمل',
      assetPath: 'assets/reactions/disappointed.jpg',
      keyPoints: {
        'mouthWidth': 85.0, // Slightly narrower than neutral
        'eyebrowTension': 18.0, // Higher tension (more raised in center)
        'eyeOpenness': 0.6, // Slightly less open than neutral
        'smileProbability': 0.2, // Very low smile probability
        'mouthCornersDown': 12.0, // Additional parameter for disappointed look
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حدد رد فعل'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(194, 217, 209, 1),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: reactions.length,
        itemBuilder: (context, index) {
          return ReactionCard(
            reaction: reactions[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraComparisonScreen(
                    selectedReaction: reactions[index],
                    useFrontCamera: true,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReactionCard extends StatelessWidget {
  final Reaction reaction;
  final VoidCallback onTap;

  const ReactionCard({super.key, required this.reaction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  reaction.assetPath,
                  fit: BoxFit.scaleDown,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                reaction.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
