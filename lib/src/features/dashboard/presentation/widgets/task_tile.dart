import 'package:flutter/material.dart';

class TaskTileWidget extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;
  final bool done;
  final VoidCallback onToggle;

  const TaskTileWidget({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.done,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: done ? Colors.black : const Color(0xFFBBBBBB),
                  width: 2,
                ),
                color: done ? Colors.black : Colors.transparent,
              ),
              child: done
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: done ? Colors.black38 : Colors.black87,
                    decoration: done ? TextDecoration.lineThrough : null,
                    decorationColor: Colors.black38,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.black38,
              ),
              const SizedBox(height: 5),
              Text(
                dateTime,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
