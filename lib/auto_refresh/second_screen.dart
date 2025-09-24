import 'package:auto_route/auto_route.dart';
import 'package:custom_widgets/auto_refresh/app_router.dart';
import 'package:custom_widgets/auto_refresh/base_screen.dart';
import 'package:custom_widgets/auto_refresh/data_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with AutoRefresh {
  @override
  Widget build(BuildContext context) {
    final store = context.read<DataStore>();

    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            store.fetchApi(); // force update
            appRouter.back();
          },
          child: Text("Update & Go Back"),
        ),
      ),
    );
  }
}
