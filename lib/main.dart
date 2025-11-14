import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/dictionaries/screens/dictionaries_screen.dart';
import 'features/learning/screens/flashcard/flashcard_screen.dart';
import 'features/learning/screens/learning_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'features/learning/screens/topic_settings/topic_settings_screen.dart';
import 'features/learning/screens/word_preview/word_preview_screen.dart';
import 'models/topic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/dictionaries',
    routes: [
      GoRoute(path: '/dictionaries', builder: (_, __) => const DictionariesScreen()),
      GoRoute(path: '/learning', builder: (_, __) => const LearningScreen()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
      GoRoute(path: '/topic_settings', builder: (_, __) => const TopicSettingsScreen()),
      GoRoute(path: '/word_preview', builder: (_, __) => const WordPreviewScreen()),
      GoRoute(
        path: '/flashcard',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FlashCardScreen(
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
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}