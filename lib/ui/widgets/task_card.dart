import 'package:flutter/material.dart';

class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
  });

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
              "Title\n Getting Started",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Description\nEvery goal starts with a task. Plan it here and take the first step!',
              style: TextStyle(color: Colors.black45),
            ),
            Text('Date:12/2/2025'),
            Row(
              children: [
                Chip(
                  label: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.yellow,
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
