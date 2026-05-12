import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/filter_chip_widget.dart';
import '../widgets/task_tile.dart';

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
                return TaskTileWidget(
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
                        FilterChipWidget(
                          label: 'Today',
                          selected: _selectedFilter == 0,
                          onTap: () => setState(() => _selectedFilter = 0),
                        ),
                        FilterChipWidget(
                          label: 'This Week',
                          selected: _selectedFilter == 1,
                          onTap: () => setState(() => _selectedFilter = 1),
                        ),
                        FilterChipWidget(
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

