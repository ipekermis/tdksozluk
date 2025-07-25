import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as context;
import 'package:provider/provider.dart';
import 'package:tdksozluk/application/repository/tdk_repository.dart';



import '../../../utilities/local_storage_helper.dart';
import '../../models/tdk_models.dart';
import 'home_contoller.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
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
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();
    //final homeController = Provider.of<HomeController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Fetch Data Example')),
      body:  Column(
          children: [
            TextField(
              controller: homeController.textController,
              onChanged: (value) => homeController.onTextChanged(),
              onSubmitted: (value) => homeController.onSubmit(value, context),
            ),
            const SizedBox(height: 10),
            if (context.watch<HomeController>().searchHistory.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text(
                      "Son Aramalar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),

                      onPressed: homeController.deleteSearchHistory,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: homeController.searchHistory.length,
                      itemBuilder: (context, index) {
                        final word = homeController.searchHistory[index];
                        return ListTile(
                          title: Text(word),
                          trailing: IconButton(
                            onPressed: () => homeController.removeHistoryItem(word),
                            icon: const Icon(Icons.close),
                          ),
                          onTap: () {
                            homeController.textController.text = word;
                            homeController.onSubmit(word, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            FutureBuilder<Madde?>(
              future: context.select<HomeController,Future<Madde?>?>(( p)=>p.futureMadde),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showErrorDialog(context, snapshot.error.toString());
                  });
                  return SizedBox.shrink();
                } else if (snapshot.data == null || !snapshot.hasData) {
                  return SizedBox.shrink();
                } else {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.madde,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        snapshot.data!.anlamlarListe[0].anlam,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        )
    );
  }
}