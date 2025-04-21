import 'package:medilink/utils/exporter.dart';

class CategoryController extends AutoDisposeNotifier<String> {
  @override
  String build() => 'General';
  void updateFilter(String newFilter) {
    state = newFilter;
    // print("filter value changed!");
  }
}
