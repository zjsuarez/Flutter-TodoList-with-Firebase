import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedFilter = 0;

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Design new landing page',
      'description': 'Create wireframes and mockups',
      'date': 'Today, 9:00 AM',
      'done': false,
    },
    {
      'title': 'Review pull requests',
      'description': 'Check open PRs on GitHub',
      'date': 'Today, 11:30 AM',
      'done': false,
    },
    {
      'title': 'Team standup meeting',
      'description': 'Daily sync with the dev team',
      'date': 'Today, 2:00 PM',
      'done': false,
    },
    {
      'title': 'Write unit tests',
      'description': 'Cover auth and data layers',
      'date': 'Today, 4:00 PM',
      'done': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning,',
                    style: GoogleFonts.dmSans(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Justin',
                    style: GoogleFonts.dmSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: const Divider(height: 1, thickness: 1, color: Color(0xFFE4E4E4)),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
              child: Text(
                'You have ${_tasks.where((t) => !(t['done'] as bool)).length} tasks today',
                style: GoogleFonts.dmSans(fontSize: 13, color: Colors.black38),
              ),
            ),

            const Spacer(),

            // Task list
            Column(
              children: List.generate(_tasks.length * 2 - 1, (i) {
                if (i.isOdd) {
                  return const Divider(
                    height: 1,
                    indent: 62,
                    endIndent: 0,
                    color: Color(0xFFEEEEEE),
                  );
                }
                final index = i ~/ 2;
                final task = _tasks[index];
                return _TaskTile(
                  title: task['title'] as String,
                  description: task['description'] as String,
                  dateTime: task['date'] as String,
                  done: task['done'] as bool,
                  onToggle: () {
                    setState(() {
                      _tasks[index]['done'] = !(_tasks[index]['done'] as bool);
                    });
                  },
                );
              }),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: const Divider(height: 1, thickness: 1, color: Color(0xFFE4E4E4)),
            ),
            // Bottom bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        _FilterChip(
                          label: 'Today',
                          selected: _selectedFilter == 0,
                          onTap: () => setState(() => _selectedFilter = 0),
                        ),
                        _FilterChip(
                          label: 'This Week',
                          selected: _selectedFilter == 1,
                          onTap: () => setState(() => _selectedFilter = 1),
                        ),
                        _FilterChip(
                          label: 'All',
                          selected: _selectedFilter == 2,
                          onTap: () => setState(() => _selectedFilter = 2),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 26),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;
  final bool done;
  final VoidCallback onToggle;

  const _TaskTile({
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.black45,
          ),
        ),
      ),
    );
  }
}
