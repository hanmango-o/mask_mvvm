import 'package:flutter/material.dart';
import 'package:mask_mvvm/ui/widget/remain_stat_list_tile.dart';
import 'package:mask_mvvm/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("현재 마스크 파는 ${storeModel.stores.length} 곳"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              storeModel.fetch();
            },
          )
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores.map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: RemainStatListTile(store: e),
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
}
