import 'package:custom_widgets/api_manager.dart';
import 'package:custom_widgets/app_button_demo.dart';
import 'package:custom_widgets/app_image_demo.dart';
import 'package:custom_widgets/app_list_view_demo.dart';
import 'package:custom_widgets/app_navigator_demo.dart';
import 'package:custom_widgets/app_text_field.dart';
import 'package:custom_widgets/auto_refresh/data_store.dart';
import 'package:custom_widgets/extension_demo.dart';
import 'package:custom_widgets/image_picker/image_picker_demo.dart';
import 'package:custom_widgets/location/location_demo.dart';
import 'package:custom_widgets/network_manager.dart';
import 'package:custom_widgets/permission/app_permission_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force black status bar with white icons globally
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Black background
      statusBarIconBrightness: Brightness.light, // White icons (Android)
      statusBarBrightness: Brightness.dark, // White icons (iOS)
    ),
  );

  runApp(
    MultiProvider(
      providers: [Provider<DataStore>(create: (_) => DataStore())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 👈 matches nav bar
        appBarTheme: AppBarTheme(backgroundColor: Colors.red),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: MainPage(),
      // routerDelegate: appRouter.delegate(
      //   navigatorObservers: () => [
      //     globalRouteObserver,
      //   ], // important for auto-refresh
      // ),
      // routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final Map<String, Widget> demoItems = {
    "Button Demo": const AppButtonDemo(),
    "TextField Demo": AppTextFieldDemo(),
    "Extensions Demo": const ExtensionsDemoPage(),
    "ListView Demo": const AppListViewDemo(),
    "App Image Demo": const AppImageDemo(),
    "App Navigator Demo": const AppNavigatorDemo(),
    "Image Picker Demo": const ImagePickerDemo(),
    "Permission Demo": const AppPermissionDemo(),
    "Location Demo": const LocationDemo(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Widgets Demo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final title = demoItems.keys.elementAt(index);
          final page = demoItems.values.elementAt(index);
          return ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 30);
        },
        itemCount: demoItems.length,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NetworkManager networkManager = NetworkManager();
  late ApiManager apiManager;

  @override
  void initState() {
    super.initState();
    networkManager.initialize(context);
    apiManager = ApiManager(networkManager: networkManager);

    // Example: call API when network is available
    autorun((_) async {
      if (networkManager.isConnected) {
        final response = await apiManager.getRequest(
          'https://jsonplaceholder.typicode.com/todos/1',
        );
        if (response != null) print(response.data);
      }
    });
  }

  @override
  void dispose() {
    networkManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Network Aware API")),
      body: Center(
        child: Observer(
          builder: (_) {
            return Text(
              networkManager.isConnected
                  ? "Connected to Internet"
                  : "No Internet Connection",
              style: const TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}
