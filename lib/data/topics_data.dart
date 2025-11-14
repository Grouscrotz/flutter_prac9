import 'package:flutter/material.dart';
import 'package:prac9/models/topic.dart';
import 'package:prac9/models/word.dart';

/// InheritedWidget — передаёт список тем и callback
class TopicsInherited extends InheritedWidget {
  final List<Topic> topics;
  final VoidCallback onUpdate;

  const TopicsInherited({
    super.key,
    required this.topics,
    required this.onUpdate,
    required super.child,
  });

  static TopicsInherited of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<TopicsInherited>();
    assert(result != null, 'No TopicsInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TopicsInherited oldWidget) {
    return oldWidget.topics != topics;
  }
}

/// Сервис — бизнес-логика, внедряется через GetIt
class TopicsService {
  final List<Topic> _topics;
  final VoidCallback _onUpdate;

  TopicsService(this._topics, this._onUpdate);

  List<Topic> get topics => List.unmodifiable(_topics);

  void addTopic(String name) {
    _topics.add(Topic(name: name, words: []));
    _onUpdate();
  }

  void selectTopic(Topic topic) {
    for (var t in _topics) {
      t.selected = (t == topic);
    }
    _onUpdate();
  }

  void addWord(Topic topic, String word, String translation) {
    topic.words.add(Word(word: word, translation: translation));
    _onUpdate();
  }

  void deleteWord(Topic topic, int index) {
    if (index >= 0 && index < topic.words.length) {
      topic.words.removeAt(index);
      _onUpdate();
    }
  }

  void resetProgress(Topic topic) {
    for (var w in topic.words) {
      w.learned = false;
    }
    _onUpdate();
  }

  // Инициализация
  static List<Topic> getInitialTopics() {
    return [
      Topic(name: 'Фрукты', words: [
        Word(word: 'Apple', translation: 'Яблоко', url: 'https://www.applesfromny.com/wp-content/uploads/2020/06/SnapdragonNEW.png'),
        Word(word: 'Banana', translation: 'Банан', url: 'https://img.freepik.com/free-psd/fresh-fruits-composition_23-2151371971.jpg?semt=ais_hybrid&w=740&q=80'),
        Word(word: 'Cherry', translation: 'Вишня', url: 'https://rainierfruit.com/wp-content/uploads/2021/11/Rainier-Fruit-Cherries.png'),
        Word(word: 'Orange', translation: 'Апельсин', url: 'https://lh3.googleusercontent.com/proxy/L5cilbcVrbLsGoMipa4F2W6OYFrp-xelWPCg7C_5sLdjLY-rrBhDB1SVU0W7iajUTtUO0NP5rF9uQnQvKZK72GJNasauveg0aLIkaZHp1nz730UWoS4CSZmC-jwTxrhy6bqA9kLQH49CTw'),
        Word(word: 'Grape', translation: 'Виноград'),
        Word(word: 'Pineapple', translation: 'Ананас'),
        Word(word: 'Mango', translation: 'Манго'),
        Word(word: 'Peach', translation: 'Персик'),
        Word(word: 'Strawberry', translation: 'Клубника'),
        Word(word: 'Lemon', translation: 'Лимон'),
      ]),
      Topic(name: 'Животные', words: [
        Word(word: 'Dog', translation: 'Собака'),
        Word(word: 'Cat', translation: 'Кошка'),
        Word(word: 'Elephant', translation: 'Слон'),
        Word(word: 'Tiger', translation: 'Тигр'),
        Word(word: 'Lion', translation: 'Лев'),
        Word(word: 'Bear', translation: 'Медведь'),
        Word(word: 'Wolf', translation: 'Волк'),
        Word(word: 'Fox', translation: 'Лиса'),
        Word(word: 'Rabbit', translation: 'Кролик'),
        Word(word: 'Horse', translation: 'Лошадь'),
      ]),
      Topic(name: 'Цвета', words: [
        Word(word: 'Red', translation: 'Красный'),
        Word(word: 'Blue', translation: 'Синий'),
        Word(word: 'Green', translation: 'Зелёный'),
        Word(word: 'Yellow', translation: 'Жёлтый'),
        Word(word: 'Black', translation: 'Чёрный'),
        Word(word: 'White', translation: 'Белый'),
        Word(word: 'Orange', translation: 'Оранжевый'),
        Word(word: 'Purple', translation: 'Фиолетовый'),
        Word(word: 'Pink', translation: 'Розовый'),
        Word(word: 'Brown', translation: 'Коричневый'),
      ]),
      Topic(name: 'Одежда', words: [
        Word(word: 'Shirt', translation: 'Рубашка'),
        Word(word: 'Pants', translation: 'Брюки'),
        Word(word: 'Shoes', translation: 'Обувь'),
        Word(word: 'Hat', translation: 'Шляпа'),
        Word(word: 'Coat', translation: 'Пальто'),
        Word(word: 'Skirt', translation: 'Юбка'),
        Word(word: 'Dress', translation: 'Платье'),
        Word(word: 'Socks', translation: 'Носки'),
        Word(word: 'Gloves', translation: 'Перчатки'),
        Word(word: 'Scarf', translation: 'Шарф'),
      ]),
      Topic(name: 'Транспорт', words: [
        Word(word: 'Car', translation: 'Машина'),
        Word(word: 'Bus', translation: 'Автобус'),
        Word(word: 'Train', translation: 'Поезд'),
        Word(word: 'Bicycle', translation: 'Велосипед'),
        Word(word: 'Plane', translation: 'Самолёт'),
        Word(word: 'Boat', translation: 'Лодка'),
        Word(word: 'Motorcycle', translation: 'Мотоцикл'),
        Word(word: 'Taxi', translation: 'Такси'),
        Word(word: 'Truck', translation: 'Грузовик'),
        Word(word: 'Subway', translation: 'Метро'),
      ]),
    ];
  }
}