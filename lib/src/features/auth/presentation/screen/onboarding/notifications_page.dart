import 'package:flutter/material.dart';
import 'package:todolistfirebase/src/features/auth/presentation/widgets/onboarding/step_shell.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return StepShell(
      emoji: '🔔',
      title: 'Don\'t miss anything!',
      subtitle: 'Get reminders so you never miss a task.',
      child: GestureDetector(
        onTap: () => onChanged(!enabled),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: enabled ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: enabled ? Colors.black : Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Icon(
                enabled
                    ? Icons.notifications_active
                    : Icons.notifications_off_outlined,
                color: enabled ? Colors.white : Colors.black38,
                size: 24,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task reminders',
                      style: TextStyle(
                        color: enabled ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      enabled
                          ? "You'll be notified about your tasks"
                          : 'Notifications are off',
                      style: TextStyle(
                        color: enabled ? Colors.white60 : Colors.black38,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: enabled,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: Colors.white24,
                inactiveThumbColor: Colors.black26,
                inactiveTrackColor: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
