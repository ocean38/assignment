import 'package:assignment/controller/controller.dart';
import 'package:assignment/widgets/card_board.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Controller();

  String? draggedItem;
  int? draggedIndex;

  @override
  void initState() {
    super.initState();
    _controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: _controller.title.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) => _buildVerticalList(i),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 10),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              notify(() => _controller.addList());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalList(int listIndex) {
    return Stack(
      children: [
        Draggable<String>(
          data: _controller.title[listIndex],
          feedback: Material(
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Opacity(
                opacity: 0.5,
                child: CardBoard(
                  listIndex: listIndex,
                  controller: _controller,
                  notify: notify,
                ),
              ),
            ),
          ),
          childWhenDragging: CardBoard(
            listIndex: listIndex,
            controller: _controller,
            notify: notify,
          ),
          onDragStarted: () {
            notify(() {
              draggedItem = _controller.title[listIndex];
              draggedIndex = listIndex;
            });
          },
          onDragCompleted: () => refresh,
          onDraggableCanceled: (_, __) => refresh,
          child: DragTarget<String>(
            onAcceptWithDetails: (receivedItem) {
              final temp = _controller.boardData[listIndex];
              _controller.boardData[listIndex] =
                  _controller.boardData[draggedIndex ?? 0];
              _controller.boardData[draggedIndex ?? 0] = temp;

              notify(() {
                _controller.title.remove(receivedItem.data);
                _controller.title.insert(listIndex, receivedItem.data);
              });
            },
            builder: (context, acceptedData, rejectedData) {
              return CardBoard(
                listIndex: listIndex,
                controller: _controller,
                notify: notify,
              );
            },
          ),
        ),
      ],
    );
  }

  void notify(void Function() fn) => setState(fn);

  void refresh() {
    notify(() {
      draggedItem = null;
      draggedIndex = null;
    });
  }
}
