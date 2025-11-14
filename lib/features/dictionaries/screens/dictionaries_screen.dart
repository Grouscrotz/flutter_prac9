import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dictionaries_cubit.dart';
import '../bloc/dictionaries_state.dart';
import '../widgets/topic_card.dart';

class DictionariesScreen extends StatelessWidget {
  const DictionariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DictionariesCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Словари')),
        body: BlocBuilder<DictionariesCubit, DictionariesState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.topics.length,
              itemBuilder: (_, i) {
                final topic = state.topics[i];
                return TopicCard(
                  topic: topic,
                  selected: topic.selected,
                  onTap: () => context.read<DictionariesCubit>().selectTopic(i),
                  onResetProgress: () => context.read<DictionariesCubit>().resetProgress(i),
                  onShowWords: () => _showWords(context, i),
                  onAddWord: () => _showAddWord(context, i),
                );
              },
            );
          },
        ),
        floatingActionButton: _buildFAB(context),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    final controller = TextEditingController();
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Новая тема'),
          content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Название')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<DictionariesCubit>().addTopic(controller.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  void _showAddWord(BuildContext context, int topicIndex) {
    final wordCtrl = TextEditingController();
    final transCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Добавить слово'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: wordCtrl, decoration: const InputDecoration(labelText: 'Слово')),
          TextField(controller: transCtrl, decoration: const InputDecoration(labelText: 'Перевод')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (wordCtrl.text.isNotEmpty && transCtrl.text.isNotEmpty) {
                context.read<DictionariesCubit>().addWord(topicIndex, wordCtrl.text, transCtrl.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showWords(BuildContext context, int topicIndex) {
    final cubit = context.read<DictionariesCubit>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(cubit.state.topics[topicIndex].name),
        content: SizedBox(
          width: 300, height: 300,
          child: ListView.builder(
            itemCount: cubit.state.topics[topicIndex].words.length,
            itemBuilder: (_, i) {
              final w = cubit.state.topics[topicIndex].words[i];
              return ListTile(
                title: Text(w.word),
                subtitle: Text(w.translation),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    cubit.deleteWord(topicIndex, i);
                    Navigator.pop(context);
                    _showWords(context, topicIndex);
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