import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:prac9/data/topics_data.dart';
import 'features/dictionaries/screens/dictionaries_screen.dart';
import 'features/learning/screens/flashcard_screen.dart';
import 'features/learning/screens/learning_screen.dart';
import 'features/learning/screens/topic_settings_screen.dart';
import 'features/learning/screens/word_preview_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'models/topic.dart';

final getIt = GetIt.instance;

void main() {
  final topics = TopicsService.getInitialTopics();
  VoidCallback? updateCallback;

  getIt.registerLazySingleton<TopicsService>(
        () => TopicsService(topics, () => updateCallback?.call()),
  );

  runApp(MyApp(topics: topics,
    setUpdateCallback: (cb) => updateCallback = cb,
  ));
}

class MyApp extends StatefulWidget {
  final List<Topic> topics;
  final Function(VoidCallback) setUpdateCallback;

  const MyApp({super.key, required this.topics, required this.setUpdateCallback});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final List<Topic> _topics;

  @override
  void initState() {
    super.initState();
    _topics = widget.topics;
    widget.setUpdateCallback(() => setState(() {}));
  }

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
    return TopicsInherited(
      topics: _topics,
      onUpdate: () => setState(() {}),
      child: MaterialApp.router(
        title: 'Приложение для изучения иностранных слов',
        theme: ThemeData(primarySwatch: Colors.indigo),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}