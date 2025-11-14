import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/learning_cubit.dart';
import '../bloc/learning_state.dart';
import '../widgets/button.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Изучение')),
        body: BlocBuilder<LearningCubit, LearningState>(
          builder: (context, state) {
            return Container(
              color: const Color(0xFFcfd9df),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Словарь: ${state.topic.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 30),
                        MyButton(
                          icon: Icons.settings,
                          iconColor: Colors.blue,
                          label: 'Настройки словаря',
                          counter: 1,
                          onPressed: () => context.push('/topic_settings'),
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                          icon: Icons.play_arrow,
                          iconColor: Colors.green,
                          label: 'Учить новые слова',
                          counter: state.newCount,
                          onPressed: () => context.push('/flashcard', extra: {'topic': state.topic, 'learningNew': true}),
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                          icon: Icons.refresh,
                          iconColor: Colors.orangeAccent,
                          label: 'Повторить слова',
                          counter: state.repeatCount,
                          onPressed: () => context.push('/flashcard', extra: {'topic': state.topic, 'learningNew': false}),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: _buildBottomNav(context, 1),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        if (i == 0) context.go('/dictionaries');
        if (i == 2) context.go('/progress');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Словари'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Изучение'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Прогресс'),
      ],
    );
  }
}