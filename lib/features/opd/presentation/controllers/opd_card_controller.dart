import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class CardController extends FamilyAsyncNotifier<List<CardModel>, String> {
  final CardRepository _cardRepository = CardRepository();
  @override
  FutureOr<List<CardModel>> build(String arg) {
    return fetchOpdCards(arg);
  }

  Future<List<CardModel>> fetchOpdCards(String userId) async {
    return _cardRepository.getOpdCards(id: userId);
  }
}
