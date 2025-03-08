import 'package:medilink/utils/exporter.dart';

class AddressController extends AsyncNotifier<AddressModel?> {
  @override
  Future<AddressModel> build() async {
    return await loadAddressJsonData();
  }

  Future<AddressModel> loadAddressJsonData() async {
    try {
      // Load JSON data
      final String pdJsonString = await rootBundle
          .loadString('assets/json_data/provinces-districts.json');
      final String dsJsonString = await rootBundle
          .loadString('assets/json_data/districts-subdistricts.json');

      // Decode JSON
      final List<dynamic> provinceDistrictJson = jsonDecode(pdJsonString);
      final List<dynamic> districtSubdistrictJson = jsonDecode(dsJsonString);

      final Map<String, List<String>> provinceData = {
        for (var item in provinceDistrictJson)
          item['province']: List<String>.from(item['districts'] ?? [])
      };
      final Map<String, List<String>> districtData = {
        for (var item in districtSubdistrictJson)
          item['district']: List<String>.from(item['subdistricts'] ?? [])
      };

      return AddressModel(
        provincesDistricts: provinceData,
        provinces: provinceData.keys.toList(),
        districtsSubdistricts: districtData,
      );
    } catch (e) {
      debugPrint('Error loading address JSON: $e');
      return AddressModel(
        provincesDistricts: {},
        provinces: [],
        districtsSubdistricts: {},
      );
    }
  }

  void selectProvince(String province) {
    if (state.value != null) {
      final districts = state.value!.provincesDistricts[province] ?? [];
      state = AsyncData(state.value!.copyWith(
        selectedProvince: province,
        districts: districts,
        selectedDistrict: null,
        subDistricts: [],
        selectedSubDistrict: null,
      ));
    }
  }

  void selectDistrict(String? district) {
    if (state.value != null) {
      final subDistricts = state.value!.districtsSubdistricts[district] ?? [];
      state = AsyncData(state.value!.copyWith(
        selectedDistrict: district,
        subDistricts: subDistricts,
        selectedSubDistrict: null,
      ));
    }
  }

  void selectSubDistrict(String? subDistrict) {
    if (state.value != null) {
      state =
          AsyncData(state.value!.copyWith(selectedSubDistrict: subDistrict));
    }
  }
}
