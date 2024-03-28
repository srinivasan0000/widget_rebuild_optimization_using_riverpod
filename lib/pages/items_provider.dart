import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemListNotifier extends AutoDisposeNotifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void addItem(String data) {
    state = [...state, data];
  }

  void removeItem(String data) {
    state = state.where((element) => element != data).toList();
  }
}

final itemListProvider = NotifierProvider.autoDispose<ItemListNotifier, List<String>>(ItemListNotifier.new);
