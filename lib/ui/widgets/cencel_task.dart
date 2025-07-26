import 'package:flutter/material.dart';

class CencelTask extends StatefulWidget {
  const CencelTask({super.key});

  @override
  State<CencelTask> createState() => _CencelTaskState();
}

class _CencelTaskState extends State<CencelTask> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title:\n No Longer Needed",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Description\nThis task has been cancelled. Sometimes, letting go is part of making space for better opportunities",
              style: TextStyle(color: Colors.black45),
            ),
            Text('Date:6/6/2025'),
            Row(
              children: [
                Chip(
                  label: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
