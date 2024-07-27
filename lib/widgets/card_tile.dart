import 'package:assignment/controller/controller.dart';
import 'package:flutter/material.dart';

class CardsTile extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final Controller controller;
  final Function removeCard;

  const CardsTile({
    super.key,
    required this.title,
    required this.description,
    required this.controller,
    required this.removeCard,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    iconSize: 16,
                    onPressed: () => removeCard(),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(thickness: 0.5),
              Text(
                description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 5),
              Text(
                'Date created: $date',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
