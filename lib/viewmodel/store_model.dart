import 'package:flutter/foundation.dart';
import 'package:mask_mvvm/model/store.dart';
import 'package:mask_mvvm/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  bool isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}
