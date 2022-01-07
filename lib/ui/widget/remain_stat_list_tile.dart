import 'package:flutter/material.dart';
import 'package:mask_mvvm/model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  const RemainStatListTile({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRemainStatWidget(store);
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
