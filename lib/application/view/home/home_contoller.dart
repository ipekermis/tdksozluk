import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/local_storage_helper.dart';
import '../../models/tdk_models.dart';
import '../../repository/tdk_repository.dart';
import '../detailed/detailed_screen.dart';

class HomeController extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  Timer? _timer;
  Future<Madde?>? futureMadde;
  List<String> searchHistory = [];
  List<String> favoriteWords = [];

  HomeController() {
    //   //textController.addListener(onTextChanged);
    _loadSearchHistory();
    _loadFavoriteWords();
  }

  @override
  void dispose() {
    textController.dispose();
    _timer?.cancel();
    super.dispose();
  }
  void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
        title: const Text("Hata"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmit(String value, BuildContext context) async {
    try {
      if (value.isNotEmpty) {
        final result = await TDKRepository().getMaddeItem(value);
        futureMadde = Future.value(result);
        await addToSearchHistory(value);
        if (result != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => DetailScreen(madde: result)),
          );
        }
        textController.clear();
      }
    } catch (e) {
      _showErrorDialog(context, "Kelime Bulunamadı");
    } finally {
      notifyListeners();
    }
  }

  Future<void> onTextChanged() async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () async {
      final text = textController.text.trim();

      if (text.isNotEmpty) {
        futureMadde = TDKRepository().getMaddeItem(text);
      } else {
        futureMadde = null;
      }
      notifyListeners();
    });
  }

  void _loadSearchHistory() {
    searchHistory = LocalStorageHelper().getLastSearchedWords();
    notifyListeners();
  }
  void _loadFavoriteWords() {
    favoriteWords = LocalStorageHelper().getFavoriteWords();
    notifyListeners();
  }
  Future<void> addToFavoriteWord(String word) async {
    await LocalStorageHelper().addToFavWord(word);
    _loadFavoriteWords();
  }


  Future<void> addToSearchHistory(String word) async {
    await LocalStorageHelper().addSearchedWord(word);
    _loadSearchHistory();
  }
  void toggleFavorite(String word) {
    if (isFavorite(word)) {
      removeFavoriteItem(word);
    } else {
      addToFavoriteWord(word);
    }

  }
  bool isFavorite(String word) {
    return favoriteWords.contains(word);
  }

  void deleteSearchHistory() {
    LocalStorageHelper().clearSearchedWords();
    _loadSearchHistory();
  }

  Future<void> removeHistoryItem(String word) async {
    await LocalStorageHelper().removeWord(word);
    _loadSearchHistory();
  }
  Future<void> removeFavoriteItem(String word) async {
    await LocalStorageHelper().removeFavWord(word);
    _loadFavoriteWords();
  }


}
