import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../application/models/tdk_models.dart';
import '../dto/tdk_dto.dart';

Future<MaddeDto?> getMadde( String search) async {

    final dio = Dio();
    dio.options.headers['User-Agent'] =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/112.0.0.0 Safari/537.36';

    final response = await dio.get(
      'https://sozluk.gov.tr/gts',
      queryParameters: {"ara": search},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.data);
      if (result is Map && result.containsKey("error"))
        throw Exception("Kelime bulunamadı: \"$search\"");


      return MaddeDto.fromJson(result[0]);

    } else {
      throw Exception("Sunucu hatası: ${response.statusCode}");
    }

}