import 'package:medilink/utils/exporter.dart';

class SearchFilterController extends AutoDisposeNotifier<String> {
  @override
  String build() => "Doctors";
  void updateFilter(String newFilter) {
    state = newFilter;
    // print("filter value changed!");
  }
}
