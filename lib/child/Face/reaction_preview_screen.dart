import 'package:autisticchildren/child/Face/CameraComparisonScreen.dart';
import 'package:autisticchildren/child/Face/reactii_model.dart';
import 'package:flutter/material.dart';

class ReactionPreviewScreen extends StatelessWidget {
  final Reaction reaction;

  const ReactionPreviewScreen({super.key, required this.reaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(reaction.name)),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                reaction.assetPath,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_front),
                    label: const Text('Front Camera'),
                    onPressed: () => _navigateToCamera(context, true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_rear),
                    label: const Text('Back Camera'),
                    onPressed: () => _navigateToCamera(context, false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCamera(BuildContext context, bool useFrontCamera) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraComparisonScreen(
          selectedReaction: reaction,
          useFrontCamera: useFrontCamera,
        ),
      ),
    );
  }
}
