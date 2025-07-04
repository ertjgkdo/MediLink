import 'package:http/http.dart' as http;
import 'exporter.dart';

extension DebounceAndCancelExtension on Ref {
  /// Wait for [duration] (defaults to 500ms), and then return a [http.Client]
  /// which can be used to make a request.
  ///
  /// That client will automatically be closed when the provider is disposed.
  Future<http.Client> getDebouncedHttpClient([Duration? duration]) async {
    // First, we handle debouncing.
    var didDispose = false;
    onDispose(() => didDispose = true);
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 1000));

    // If the provider was disposed during the delay, it means that the user
    // refreshed again. We throw an exception to cancel the request.
    // It is safe to use an exception here, as it will be caught by Riverpod.
    if (didDispose) {
      throw Exception('Cancelled');
    }

    // We now create the client and close it when the provider is disposed.
    final client = http.Client();
    onDispose(client.close);

    // Finally, we return the client to allow our provider to make the request.
    return client;
  }
}
