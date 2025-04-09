import 'package:medilink/utils/exporter.dart';

class HospitalSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '', // Clear search
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context), // Close search
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    late final hospitalSearchProvider = FutureProvider((ref) async {
      final client = await ref.getDebouncedHttpClient();
      return HospitalRepository(localClient: client).searchHospitals(
        query: query,
      );
    });
    print("buildResults triggered with query: $query");
    return Consumer(builder: (context, ref, child) {
      final searchResults = ref.watch(hospitalSearchProvider);
      return searchResults.when(
        data: (results) {
          print("Search results: $results");
          return searchResultList(
            results: results,
          );
        },
        loading: () => Center(child: Container()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    late final hospitalSearchProvider = FutureProvider((ref) async {
      final client = await ref.getDebouncedHttpClient();
      return HospitalRepository(localClient: client).searchHospitals(
        query: query,
      );
    });
    if (query.isEmpty) {
      return Center(child: Text("Type to search..."));
    }

    return Consumer(builder: (context, ref, child) {
      final searchResults = ref.watch(hospitalSearchProvider);
      return searchResults.when(
        data: (results) => searchResultList(results: results),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      );
    });
  }
}
