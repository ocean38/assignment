import 'package:assignment/models/model.dart';
import 'package:assignment/utils/sample_data.dart';

class Controller {
  late final CardModel? cardData;
  List<List<CardDetailsModel>> boardData = [];
  List<String> title = [];

  void getData() {
    cardData = CardModel.fromJson(jsonData);
    _createBoardData();
    _createBoardTitle();
  }

  void _createBoardData() {
    for (ListModel lane in cardData?.lanes ?? []) {
      final cardTitles = lane.cards.map((card) => card).toList();
      boardData.add(cardTitles);
    }
  }

  void _createBoardTitle() {
    List.generate(
      cardData?.lanes.length ?? 0,
      (i) => title.add(cardData?.lanes[i].title ?? ''),
    );
  }

  void addCard(int listIndex) {
    boardData[listIndex].add(
      CardDetailsModel(
        description: 'Description',
        title: 'Title',
        createdDate: DateTime.now(),
      ),
    );
  }

  void removeCard(int listINdex, int itemIndex) {
    boardData[listINdex].removeAt(itemIndex);
  }

  void editTitle(String title, int listINdex, int itemIndex) {
    boardData[listINdex][itemIndex].title = title;
  }

  void editDescription(String description, int listINdex, int itemIndex) {
    boardData[listINdex][itemIndex].description = description;
  }

  void addList() {
    boardData.add([]);
    title.add('New List');
  }

  void removeList(listIndex) {
    boardData.removeAt(listIndex);
    title.removeAt(listIndex);
  }
}
