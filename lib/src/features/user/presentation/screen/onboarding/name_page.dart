import 'package:flutter/material.dart';
import 'package:todolistfirebase/src/features/user/presentation/widgets/onboarding/step_shell.dart';

class NamePage extends StatelessWidget {
  const NamePage({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return StepShell(
      emoji: '👋',
      title: "What's your name?",
      subtitle: "We'd love to know what to call you.",
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.name,
          decoration: onboardingInputDecoration('Full name'),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Please enter your name';
            if (v.trim().length < 2) return 'Name is too short';
            return null;
          },
        ),
      ),
    );
  }
}
