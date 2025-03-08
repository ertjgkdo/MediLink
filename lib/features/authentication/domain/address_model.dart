class AddressModel {
  final Map<String, List<String>> provincesDistricts;
  final Map<String, List<String>> districtsSubdistricts;
  final String? selectedProvince;
  final String? selectedDistrict;
  final String? selectedSubDistrict;
  final List<String> provinces;
  final List<String> districts;
  final List<String>? subDistricts;

  AddressModel({
    this.provincesDistricts = const {},
    this.districtsSubdistricts = const {},
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedSubDistrict,
    this.districts = const [],
    this.provinces = const [],
    this.subDistricts,
  });

  AddressModel copyWith({
    Map<String, List<String>>? provincesDistricts,
    Map<String, List<String>>? districtsSubdistricts,
    String? selectedProvince,
    String? selectedDistrict,
    String? selectedSubDistrict,
    List<String>? provinces,
    List<String>? districts,
    List<String>? subDistricts,
  }) {
    return AddressModel(
      provincesDistricts: provincesDistricts ?? this.provincesDistricts,
      districtsSubdistricts:
          districtsSubdistricts ?? this.districtsSubdistricts,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedSubDistrict: selectedSubDistrict ?? this.selectedSubDistrict,
      districts: districts ?? this.districts,
      subDistricts: subDistricts ?? this.subDistricts,
    );
  }
}
