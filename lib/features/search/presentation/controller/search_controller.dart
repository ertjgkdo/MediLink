// import 'dart:async';

// import 'package:medilink/utils/exporter.dart';

// class EntitySearchController
//     extends FamilyAsyncNotifier<List<dynamic>, SearchModel> {
//   @override
//   FutureOr<List<dynamic>> build(SearchModel arg) async {
//     print("Fetching search results for: ${arg.query} - ${arg.selectedfilter}");
//     if (arg.query.isEmpty) return []; // No search input, return empty
//     final client =
//         await ref.getDebouncedHttpClient(const Duration(milliseconds: 500));

//     final searchRepo = SearchRepository<dynamic>(
//       localClient: client,
//       fromJsonFunc: (map) {
//         switch (arg.selectedfilter) {
//           case "Doctors":
//             return Doctor.fromJson(map);
//           case "Departments":
//             return Department.fromJson(map);
//           case "Hospitals":
//             return Hospital.fromJson(map);
//           default:
//             throw Exception("Invalid filter type");
//         }
//       },
//       fromRawJsonFunc: (json) {
//         switch (arg.selectedfilter) {
//           case "Doctors":
//             return Doctor.fromRawJson(json);
//           case "Departments":
//             return Department.fromRawJson(json);
//           case "Hospitals":
//             return Hospital.fromRawJson(json);
//           default:
//             throw Exception("Invalid filter type");
//         }
//       },
//     );

//     return searchRepo.search(
//         searchEndpoint: arg.selectedfilter, query: arg.query);
//   }
// }
