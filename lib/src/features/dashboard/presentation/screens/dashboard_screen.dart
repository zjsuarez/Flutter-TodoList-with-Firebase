import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/task.dart';
import '../bloc/dashboard/bloc/dashboard_bloc.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/task_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Column(
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
                        '[USER NAME]',
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

                // Use state.when() from Freezed to handle all UI variations!
                Expanded(
                  child: state.when(
                    initial: () => const Center(child: CircularProgressIndicator()),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text('Error: $message')),
                    loaded: (tasks) {
                      // Calculate undone tasks dynamically
                      final pendingTasksCount = tasks.where((t) => !t.isCompleted).length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
                            child: Text(
                              'You have $pendingTasksCount tasks today',
                              style: GoogleFonts.dmSans(fontSize: 13, color: Colors.black38),
                            ),
                          ),

                          const Spacer(),

                          if (tasks.isEmpty)
                            const Center(child: Text("No tasks yet. Tap + to add one!")),

                          // Task list dynamically built from bloc state
                          if (tasks.isNotEmpty)
                            Column(
                              children: List.generate(tasks.length * 2 - 1, (i) {
                                if (i.isOdd) {
                                  return const Divider(
                                    height: 1,
                                    indent: 62,
                                    endIndent: 0,
                                    color: Color(0xFFEEEEEE),
                                  );
                                }
                                final index = i ~/ 2;
                                final task = tasks[index];
                                return TaskTileWidget(
                                  title: task.title,
                                  description: task.description,
                                  // Formatting the date nicely or just showing string
                                  dateTime: '${task.date.hour}:${task.date.minute}', 
                                  done: task.isCompleted,
                                  onToggle: () {
                                    // Make a modified copy of task directly 
                                    // and send update event!
                                    final updatedTask = Task(
                                      id: task.id,
                                      title: task.title,
                                      description: task.description,
                                      date: task.date,
                                      isCompleted: !task.isCompleted,
                                    );
                                    context.read<DashboardBloc>().add(DashboardEvent.updateTask(updatedTask));
                                  },
                                );
                              }),
                            ),
                        ],
                      );
                    },
                  ),
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
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // required so the keyboard doesn't cover the sheet
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (ctx) {
                              return AddTaskBottomSheet(
                                onAdd: (newTask) {
                                  context.read<DashboardBloc>().add(DashboardEvent.addTask(newTask));
                                },
                              );
                            },
                          );
                        },
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
            );
          },
        ),
      ),
    );
  }
}


