import 'package:flutter/material.dart';
import 'package:todolistfirebase/src/features/auth/presentation/widgets/onboarding/step_shell.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return StepShell(
      emoji: '✨',
      title: 'Pick an epic username',
      subtitle: 'This is how your friends will find you!',
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          decoration: onboardingInputDecoration('username').copyWith(
            prefixText: '@',
            prefixStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Please enter a username';
            if (v.trim().length < 3) return 'Username must be at least 3 characters';
            if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(v.trim())) {
              return 'Only letters, numbers, . and _ allowed';
            }
            return null;
          },
        ),
      ),
    );
  }
}
