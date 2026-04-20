import 'package:flutter/material.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFF0F1216),
            child: const Center(
              child: Icon(Icons.photo_camera_back_outlined, size: 120, color: Color(0xFF2A3138)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 77,
                      height: 77,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: Colors.white.withOpacity(0.08),
                      ),
                      child: const Center(
                        child: Icon(Icons.circle, size: 38, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
