import 'dart:async';

import 'package:medilink/utils/exporter.dart';

class CardController extends FamilyAsyncNotifier<List<CardModel>, String> {
  final CardRepository _cardRepository = CardRepository();
  @override
  FutureOr<List<CardModel>> build(String id) {
    return fetchOpdCards(id);
  }

  Future<List<CardModel>> fetchOpdCards(String userId) async {
    return _cardRepository.getOpdCards(id: userId);
  }
}
