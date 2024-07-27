import 'package:assignment/controller/controller.dart';
import 'package:assignment/widgets/card_tile.dart';
import 'package:flutter/material.dart';

class CardBoard extends StatelessWidget {
  final int listIndex;
  final Function notify;
  final Controller controller;

  const CardBoard({
    super.key,
    required this.listIndex,
    required this.notify,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  controller.title[listIndex],
                  maxLines: 3,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  notify(() {
                    controller.removeList(listIndex);
                  });
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DragTarget<String>(
              onWillAcceptWithDetails: (data) => true,
              onAcceptWithDetails: (details) {
                final splitData = details.data.split('|');
                final fromListIndex = int.parse(splitData[0]);
                final fromItemIndex = int.parse(splitData[1]);
                final item =
                    controller.boardData[fromListIndex].removeAt(fromItemIndex);
                notify(() {
                  final targetIndex =
                      _getTargetIndex(details, listIndex, context);
                  controller.boardData[listIndex].insert(targetIndex, item);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return ListView(
                  children: List.generate(
                    controller.boardData[listIndex].length,
                    (itemIndex) {
                      return Draggable<String>(
                        data: '$listIndex|$itemIndex',
                        feedback: Material(
                          child: _buildListItem(
                            listIndex,
                            itemIndex,
                            isDragging: true,
                          ),
                        ),
                        childWhenDragging: _buildListItem(
                          listIndex,
                          itemIndex,
                          isDragging: true,
                        ),
                        child: _buildListItem(listIndex, itemIndex),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              notify(() {
                controller.addCard(listIndex);
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  int _getTargetIndex(
      DragTargetDetails details, int listIndex, BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.globalToLocal(details.offset);
    const itemHeight = 60;
    final targetIndex = (offset.dy / itemHeight).floor();
    return targetIndex.clamp(
      0,
      (controller.boardData[listIndex].length),
    );
  }

  Widget _buildListItem(
    int listIndex,
    int itemIndex, {
    bool isDragging = false,
  }) {
    final item = controller.boardData[listIndex][itemIndex];

    return Opacity(
      opacity: isDragging ? 0.5 : 1,
      child: CardsTile(
        date:
            '${item.createdDate?.day}-${item.createdDate?.month}-${item.createdDate?.year}',
        removeCard: () {
          notify(() => controller.removeCard(listIndex, itemIndex));
        },
        controller: controller,
        title: item.title ?? '',
        description: item.description ?? '',
      ),
    );
  }
}
