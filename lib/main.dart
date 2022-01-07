import 'package:flutter/material.dart';

import 'package:mask_mvvm/ui/view/main_page.dart';
import 'package:mask_mvvm/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider.value(
        value: StoreModel(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
