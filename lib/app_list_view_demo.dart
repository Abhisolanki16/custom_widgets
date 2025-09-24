import 'package:custom_widgets/app_list_view.dart';
import 'package:flutter/material.dart';

class AppListViewDemo extends StatelessWidget {
  const AppListViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App ListView Demo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Normal ListView
          Expanded(
            child: AppListView<String>(
              items: ["Apple", "Banana", "Cherry"],
              itemBuilder: (context, index, item) {
                return ListTile(
                  leading: CircleAvatar(child: Text(item[0])),
                  title: Text(item),
                );
              },
            ),
          ),

          // ListView.separated with custom divider
          Expanded(
            child: AppListView<String>(
              items: ["One", "Two", "Three", "Four"],
              isSeparated: true,
              separator: const Divider(color: Colors.grey),
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(item),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
