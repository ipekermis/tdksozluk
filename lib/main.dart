import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdksozluk/application/view/home/home_screen.dart';
import 'package:tdksozluk/utilities/local_storage_helper.dart';
import 'dart:convert';
import 'application/models/tdk_models.dart';

import 'application/view/home/home_contoller.dart';
import 'data/dto/tdk_dto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefInstance = await SharedPreferences.getInstance();
  LocalStorageHelper(pref: prefInstance);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child:  MaterialApp(
        home: HomeScreen(), // Uygulamanın giriş noktası artık HomePage
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}




