import 'package:medilink/utils/exporter.dart';

final cardProvider =
    AsyncNotifierProvider.family<CardController, List<CardModel>, String>(
        CardController.new);
final userIdProvider = FutureProvider<String?>((ref) async {
  return await SecureStorage.getUserId();
});
final tokenProvider = FutureProvider<String?>((ref) async {
  return await SecureStorage.getToken();
});
final recordProvider =
    AsyncNotifierProvider.family<RecordController, List<RecordModel>, String>(
        RecordController.new);
