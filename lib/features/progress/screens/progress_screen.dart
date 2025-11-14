// features/progress/screens/progress_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/progress_cubit.dart';
import '../bloc/progress_state.dart';
import '../../../repository/topics_repository.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Прогресс')),
        backgroundColor: const Color(0xFFbac3c8),
        body: BlocBuilder<ProgressCubit, ProgressState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text('Общий прогресс', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(value: state.totalProgress / 100),
                          const SizedBox(height: 8),
                          Text('${state.totalProgress.toStringAsFixed(1)}% (${state.learned}/${state.total})'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: TopicsRepository().topics.length,
                      itemBuilder: (_, i) {
                        final t = TopicsRepository().topics[i];
                        final p = state.topicProgress[i];
                        return ListTile(title: Text(t.name), trailing: Text('${p.toInt()}%'));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: _buildBottomNav(context, 2),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        if (i == 0) context.go('/dictionaries');
        if (i == 1) context.go('/learning');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Словари'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Изучение'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Прогресс'),
      ],
    );
  }
}