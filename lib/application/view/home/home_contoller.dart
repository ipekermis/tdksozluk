import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/local_storage_helper.dart';
import '../../models/search_history_item.dart';
import '../../models/tdk_models.dart';
import '../../repository/tdk_repository.dart';
import '../detailed/detailed_screen.dart';

class HomeController extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  Timer? _timer;
  Future<Madde?>? futureMadde;
  List<SearchHistoryItem> searchHistory = [];
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

  void _showErrorDialog(BuildContext context, String title, String message) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text(title),
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
    if (value.trim().isEmpty) {
      futureMadde = null;
      notifyListeners();
      return;
    }

    try {
      final result = await TDKRepository().getMaddeItem(value);

      futureMadde = Future.value(result);

      if (result != null) {
        String? type;
        if (result.anlamlarListe.isNotEmpty) {
          final Anlam firstAnlam = result.anlamlarListe.first;
          if (firstAnlam.ozelliklerListe != null &&
              firstAnlam.ozelliklerListe!.isNotEmpty) {
            type = firstAnlam.ozelliklerListe!.first.tamAdi;
          }
        }
        await addToSearchHistory(
          SearchHistoryItem(word: result.madde, type: type),
        );

        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => DetailScreen(madde: result)),
        );
        textController.clear();
      } else {
        _showErrorDialog(
          context,
          "Kelime Bulunamadı",
          '"$value" kelimesi bulunamadı.',
        );
      }
    } catch (e) {
      _showErrorDialog(
        context,
        "Hata",
        'Arama sırasında bir hata oluştu: ${e.toString()}',
      );
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

  void _loadFavoriteWords() {
    favoriteWords = LocalStorageHelper().getFavoriteWords();
    notifyListeners();
  }

  Future<void> addToFavoriteWord(String word) async {
    await LocalStorageHelper().addToFavWord(word);
    _loadFavoriteWords();
  }

  Future<void> addToSearchHistory(SearchHistoryItem item) async {
    await LocalStorageHelper().addSearchedItem(item);
    _loadSearchHistory();
  }

  void _loadSearchHistory() async {
    searchHistory = await LocalStorageHelper().getLastSearchedItems();
    notifyListeners();
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
