import 'package:flutter/material.dart';

import 'package:mask_mvvm/model/store.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "현재 마스크 파는 ${storeModel.stores.where((element) => element.remainStat == 'plenty' || element.remainStat == 'some' || element.remainStat == 'few').length} 곳 정보"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              storeModel.fetch().then((value) {
                setState(() {
                  storeModel.stores = value;
                });
              });
            },
          )
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores
                  .where((element) =>
                      element.remainStat == 'plenty' ||
                      element.remainStat == 'some' ||
                      element.remainStat == 'few')
                  .map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        children: const [
          Text("정보를 가져오는 중"),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    String remainStat = '매진';
    String description = '판매 중지';
    Color stateColor = Colors.black;
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        stateColor = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        stateColor = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        stateColor = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        stateColor = Colors.grey;
        break;
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: stateColor),
        ),
        Text(
          description,
          style: TextStyle(color: stateColor),
        ),
      ],
    );
  }
}
