import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = true.obs;
    return Scaffold(
        appBar: AppBar(
          title: const Text('App lists'),
          actions: [
            Row(
              children: [
                const Icon(Icons.brightness_1),
                Obx(
                  () => Switch(
                      value: isDark.value,
                      onChanged: (value) => {
                            isDark.value = value,
                            Get.changeTheme(isDark.value
                                ? ThemeData.dark()
                                : ThemeData.light())
                          }),
                ),
                const Icon(Icons.brightness_3),
              ],
            )
          ],
        ),
        body: ListView(children: const [
          HomeMenuButton('/app_zero', 'Episode #0'),
          HomeMenuButton('/sliver_list', 'Sliver List App'),
          HomeMenuButton('/app_three', 'Episode #3'),
        ]));
  }
}

class HomeMenuButton extends StatelessWidget {
  final String route;
  final String text;

  const HomeMenuButton(this.route, this.text, [Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Get.toNamed(route),
        child: Text(text),
      ),
    );
  }
}
