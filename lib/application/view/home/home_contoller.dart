import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../utilities/local_storage_helper.dart';
import '../../models/tdk_models.dart';
import '../../repository/tdk_repository.dart';

class HomeController extends ChangeNotifier{
  final TextEditingController textController = TextEditingController();
  Timer? _timer;
  Future<Madde?>? futureMadde;
  List<String> searchHistory = [];

   HomeController() {
  //   //textController.addListener(onTextChanged);
     _loadSearchHistory();
   }
  @override
  void dispose() {
    textController.dispose();
    _timer?.cancel();
    super.dispose();
  }
  Future<void> onSubmit(String value, BuildContext context) async {
    if (value.isNotEmpty) {

        try {
          final result = await TDKRepository().getMaddeItem(value);
          futureMadde=Future.value(result);
        } catch (e) {
          print("onsubmit");
        }
        await addToSearchHistory(value);
        notifyListeners();

    }
  }

  Future<void> onTextChanged() async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () async {
      final text = textController.text.trim();
      try{
      if (text.isNotEmpty) {

        futureMadde = TDKRepository().getMaddeItem(text)..onError((e,_){print(e.toString());});

      } else {
        futureMadde = null;
      }}catch(e){
        print(e.toString());
      }
      notifyListeners();
    });
  }


  void _loadSearchHistory() {
    searchHistory = LocalStorageHelper().getLastSearchedWords();
    notifyListeners();
  }
  Future<void> addToSearchHistory(String word) async {
    await LocalStorageHelper().addSearchedWord(word);
    _loadSearchHistory();
  }
  void deleteSearchHistory() {
    LocalStorageHelper().clearSearchedWords();
    _loadSearchHistory();
  }

  Future<void> removeHistoryItem(String word) async {
    await LocalStorageHelper().removeWord(word);
    _loadSearchHistory();
  }
}
