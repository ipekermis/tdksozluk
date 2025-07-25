import 'package:tdksozluk/data/services/tdk_api_service.dart';

import '../models/tdk_models.dart';

class TDKRepository{
  TDKRepository();
   Future<Madde?> getMaddeItem(String search)async{
    final result=await getMadde( search);
    return result?.toMadde() ;
  }
}