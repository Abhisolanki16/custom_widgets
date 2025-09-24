import 'package:auto_route/auto_route.dart';
import 'package:custom_widgets/auto_refresh/app_router.dart';
import 'package:custom_widgets/auto_refresh/base_screen.dart';
import 'package:custom_widgets/auto_refresh/data_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:custom_widgets/auto_refresh/app_router.dart';

@RoutePage()
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with AutoRefresh {
  @override
  void initState() {
    super.initState();
    context.read<DataStore>().fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<DataStore>();

    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
      body: Center(
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(store.response),
              ElevatedButton(
                onPressed: () => appRouter.push(SecondRoute()),
                child: Text("Go to Second Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
