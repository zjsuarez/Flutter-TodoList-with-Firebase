import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolistfirebase/src/core/constants/app_colors.dart';
import 'package:todolistfirebase/src/core/di/injection.dart';
import 'package:todolistfirebase/src/features/user/domain/entities/user.dart';
import 'package:todolistfirebase/src/features/user/presentation/bloc/user_bloc.dart';

import 'avatar_page.dart';
import 'name_page.dart';
import 'notifications_page.dart';
import 'username_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  final _usernameFormKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  late final Color _avatarColor;
  bool _notificationsEnabled = true;

  static const int _totalPages = 4;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _avatarColor = avatarColors[rng.nextInt(avatarColors.length)];
    _usernameController.text = _suggestUsername(rng);
  }

  String _suggestUsername(Random rng) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    final localPart = email.split('@').first;
    final sanitized = localPart.replaceAll(RegExp(r'[^a-zA-Z0-9._]'), '');
    final digits = 100 + rng.nextInt(900);
    return '$sanitized$digits';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage == 0 && !_nameFormKey.currentState!.validate()) return;
    if (_currentPage == 1 && !_usernameFormKey.currentState!.validate()) return;
    if (_currentPage == _totalPages - 1) {
      final user = User(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        notificationsEnabled: _notificationsEnabled,
      );
      context.read<UserBloc>().add(UserEvent.saveUser(
        user,
        pickedImagePath: _selectedImage?.path,
      ));
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.whenOrNull(
          saved: () => context.go('/dashboard'),
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(AppColors.backgroundColor),
        body: SafeArea(
          child: Column(
            children: [
              _ProgressBar(current: _currentPage, total: _totalPages),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    NamePage(
                      controller: _nameController,
                      formKey: _nameFormKey,
                    ),
                    UsernamePage(
                      controller: _usernameController,
                      formKey: _usernameFormKey,
                    ),
                    AvatarPage(
                      name: _nameController.text,
                      selectedImage: _selectedImage,
                      fallbackColor: _avatarColor,
                      onImageSelected: (file) =>
                          setState(() => _selectedImage = file),
                    ),
                    NotificationsPage(
                      enabled: _notificationsEnabled,
                      onChanged: (v) =>
                          setState(() => _notificationsEnabled = v),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return _NavButtons(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                    onNext: _next,
                    onBack: _back,
                    isLoading: state.maybeWhen(loading: () => true, orElse: () => false),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// BAR

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        children: List.generate(total, (i) {
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
              height: 4,
              decoration: BoxDecoration(
                color: i <= current ? Colors.black : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// BUTTONS

class _NavButtons extends StatelessWidget {
  const _NavButtons({
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
    required this.isLoading,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isLast = currentPage == totalPages - 1;
    final isAvatarPage = currentPage == 2;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAvatarPage)
            TextButton(
              onPressed: onNext,
              child: const Text(
                'Skip for now',
                style: TextStyle(color: Colors.black45, fontSize: 14),
              ),
            ),
          Row(
            children: [
              if (currentPage > 0) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading ? null : onNext,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          isLast ? 'Get Started' : 'Next',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
