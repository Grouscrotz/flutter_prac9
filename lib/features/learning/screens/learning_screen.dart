import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/learning_cubit.dart';
import '../bloc/learning_state.dart';
import '../widgets/button.dart';


class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningCubit(),
      child: const LearningView(),
    );
  }
}


class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Изучение'),
        actions: [
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () => context.go('/dictionaries'),
            tooltip: 'Словари',
          ),
          IconButton(
            icon: const Icon(Icons.school),
            onPressed: () => context.go('/learning'),
            tooltip: 'Изучение',
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/progress'),
            tooltip: 'Прогресс',
          ),
        ],
      ),
      body: BlocBuilder<LearningCubit, LearningState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Словарь: ${state.topic.name}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        onPressed: () => context.push(
                          '/flashcard',
                          extra: {'topic': state.topic, 'learningNew': true},
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButton(
                        icon: Icons.refresh,
                        iconColor: Colors.orangeAccent,
                        label: 'Повторить слова',
                        counter: state.repeatCount,
                        onPressed: () => context.push(
                          '/flashcard',
                          extra: {'topic': state.topic, 'learningNew': false},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}