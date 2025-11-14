import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appObserver.dart';
import 'features/dictionaries/screens/dictionaries_screen.dart';
import 'features/learning/screens/flashcard/flashcard_screen.dart';
import 'features/learning/screens/learning_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'features/learning/screens/topic_settings/topic_settings_screen.dart';
import 'features/learning/screens/word_preview/word_preview_screen.dart';
import 'models/topic.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/dictionaries',
    routes: [
      GoRoute(path: '/dictionaries', builder: (_, __) => const DictionariesPage()),
      GoRoute(path: '/learning', builder: (_, __) => const LearningPage()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressPage()),
      GoRoute(path: '/topic_settings', builder: (_, __) => const TopicSettingsPage()),
      GoRoute(path: '/word_preview', builder: (_, __) => const WordPreviewPage()),
      GoRoute(
        path: '/flashcard',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FlashCardPage(
            topic: extra['topic'] as Topic,
            learningNew: extra['learningNew'] as bool,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Приложение для изучения иностранных слов',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFcfd9df), // Единый фон для всех экранов
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}