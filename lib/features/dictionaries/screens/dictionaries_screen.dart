import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:prac9/data/topics_data.dart';
import 'package:prac9/features/dictionaries/widgets/topic_card.dart';

import '../../../main.dart';
import '../../../models/topic.dart';

class DictionariesScreen extends StatefulWidget {
  const DictionariesScreen({super.key});

  @override
  State<DictionariesScreen> createState() => _DictionariesScreenState();
}

class _DictionariesScreenState extends State<DictionariesScreen> {
  final _controller = TextEditingController();

  late final service = getIt<TopicsService>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Словари')),
      body: ListView.builder(
        itemCount: service.topics.length,
        itemBuilder: (_, i) {
          final topic = service.topics[i];
          return TopicCard(
            topic: topic,
            selected: topic.selected,
            onTap: () => service.selectTopic(topic),
            onResetProgress: () => service.resetProgress(topic),
            onShowWords: () => _showWords(topic),
            onAddWord: () => _showAddWord(topic),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            service.addTopic(_controller.text);
            _controller.clear();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWord(Topic topic) {
    final wordCtrl = TextEditingController();
    final transCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Добавить в "${topic.name}"'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: wordCtrl, decoration: const InputDecoration(labelText: 'Слово')),
          TextField(controller: transCtrl, decoration: const InputDecoration(labelText: 'Перевод')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (wordCtrl.text.isNotEmpty && transCtrl.text.isNotEmpty) {
                service.addWord(topic, wordCtrl.text, transCtrl.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showWords(Topic topic) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(topic.name),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ListView.builder(
            itemCount: topic.words.length,
            itemBuilder: (_, i) {
              final w = topic.words[i];
              return ListTile(
                title: Text(w.word),
                subtitle: Text(w.translation),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    service.deleteWord(topic, i);
                    Navigator.pop(context);
                    _showWords(topic);
                  },
                ),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Закрыть'))],
      ),
    );
  }
}