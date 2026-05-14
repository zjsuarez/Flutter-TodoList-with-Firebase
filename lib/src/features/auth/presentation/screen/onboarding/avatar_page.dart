import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolistfirebase/src/features/auth/presentation/widgets/onboarding/step_shell.dart';

const avatarColors = [
  Color(0xFF1A1A2E),
  Color(0xFF0F3460),
  Color(0xFF533483),
  Color(0xFF2B2D42),
  Color(0xFF457B9D),
  Color(0xFF2D6A4F),
  Color(0xFFD62828),
  Color(0xFFF4A261),
];

class AvatarPage extends StatelessWidget {
  const AvatarPage({
    super.key,
    required this.name,
    required this.selectedImage,
    required this.fallbackColor,
    required this.onImageSelected,
  });

  final String name;
  final XFile? selectedImage;
  final Color fallbackColor;
  final ValueChanged<XFile> onImageSelected;

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return '?';
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) onImageSelected(file);
  }

  @override
  Widget build(BuildContext context) {
    return StepShell(
      emoji: '🖼️',
      title: 'Add a profile picture',
      subtitle: "Show the world who you are, or don't.",
      child: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: fallbackColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: fallbackColor.withAlpha(80),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              File(selectedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Text(
                              _initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _pickImage,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              label: Text(
                selectedImage != null ? 'Change photo' : 'Choose from gallery',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
