import 'package:custom_widgets/extensions.dart';
import 'package:flutter/material.dart';

class ExtensionsDemoPage extends StatelessWidget {
  const ExtensionsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = "flutter@gmail.com";
    final phone = "9876543210";
    final price = 500;
    final date = DateTime.now().subtract(const Duration(hours: 5));

    return Scaffold(
      appBar: AppBar(title: const Text("Extensions Demo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Widget Extensions
            Text(
              "Widget Extensions",
              style: context.textTheme.titleLarge,
            ).paddingOnly(b: 8),
            Text(
              "Hello with background, padding & rounded corners",
            ).paddingAll(12).bg(Colors.blue.shade100).rounded(12).shadow(),

            /// 🔹 String Extensions
            Text(
              "String Extensions",
              style: context.textTheme.titleLarge,
            ).paddingOnly(b: 8),
            Text("Is Email: ${email.isEmail}"),
            Text("Is Phone: ${phone.isPhone}"),
            Text("Title Case: ${"hello world".titleCase}"),
            Text("Masked: ${"secret123".mask()}"),
            const Divider(),

            /// 🔹 Num Extensions
            Text(
              "Num Extensions",
              style: context.textTheme.titleLarge,
            ).paddingOnly(b: 8),
            Text("Currency: ${price.toCurrency}"),
            Text("Percent: ${50.toPercent}"),
            Text("Radians: ${45.toRadians}"),
            const Divider(),

            /// 🔹 DateTime Extensions
            Text(
              "DateTime Extensions",
              style: context.textTheme.titleLarge,
            ).paddingOnly(b: 8),
            Text("Format Date: ${date.formatDate}"),
            Text("Format Time: ${date.formatTime}"),
            Text("Is Today: ${date.isToday}"),
            Text("Time Ago: ${date.timeAgo()}"),
            const Divider(),

            /// 🔹 Context Extensions (buttons to trigger)
            Text(
              "Context Extensions",
              style: context.textTheme.titleLarge,
            ).paddingOnly(b: 8),
            ElevatedButton(
              onPressed: () => context.showSnackBar("This is a snackbar!"),
              child: const Text("Show SnackBar"),
            ),
            ElevatedButton(
              onPressed: () => context.showAlert(
                title: "Confirm",
                message: "Do you want to continue?",
                onConfirm: () => context.showSnackBar("Confirmed!"),
              ),
              child: const Text("Show Alert"),
            ),
            ElevatedButton(
              onPressed: () => context.showCustomBottomSheet(
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("Option 1"),
                      onTap: () => context.pop("1"),
                    ),
                    ListTile(
                      title: Text("Option 2"),
                      onTap: () => context.pop("2"),
                    ),
                  ],
                ),
              ),
              child: const Text("Show Bottom Sheet"),
            ),
            ElevatedButton(
              onPressed: () async {
                context.showLoader();
                await Future.delayed(const Duration(seconds: 2));
                context.hideLoader();
                context.showSnackBar("Loader dismissed");
              },
              child: const Text("Show Loader"),
            ),
            ElevatedButton(
              onPressed: () {
                print(date.shortDayMonthYear); // 25 Feb 25
                print(date.fullDayMonthYear); // 25 February 2025
                print(date.dayMonthSlash); // 25/02
                print(date.dayMonthYearDash); // 25-02-2025
                print(date.monthDayYear); // Feb 25, 2025
                print(date.fullWeekDayMonthYear); // Tuesday, 25 Feb 2025
                print(date.dayWithSuffixMonthYear); // 25th Feb 2025
              },
              child: const Text("Go to Second Page"),
            ),

            Container(
              color: Colors.grey.shade200,
              child: WidgetPadding.vDiv(
                color: Colors.red,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
