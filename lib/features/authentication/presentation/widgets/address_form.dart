import 'package:medilink/utils/exporter.dart';

class AddressForm extends ConsumerWidget {
  const AddressForm({super.key, required this.formController});

  final SignUpController formController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = ref.watch(addressProvider);

    return addressState.when(
      data: (addressModel) {
        if (addressModel == null) {
          return const Center(child: Text("No address data available"));
        }
        final addressController = ref.read(addressProvider.notifier);

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "Enter your Address",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),

            // Province Dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: addressModel.selectedProvince,
                decoration: const InputDecoration(
                  labelText: 'Province',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 3), // Compact styling
                ),
                items: addressModel.provinces
                    .map((province) => DropdownMenuItem(
                          value: province,
                          child: Text(province),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    addressController.selectProvince(value);
                    addressController.selectDistrict(null);
                    addressController.selectSubDistrict(null);
                  }
                },
              ),
            ),

            // District Dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: addressModel.selectedDistrict,
                decoration: const InputDecoration(
                  labelText: 'District',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 3), // Compact styling
                ),
                items: addressModel.districts
                    .map((district) => DropdownMenuItem(
                          value: district,
                          child: Text(district),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    addressController.selectDistrict(value);
                    addressController.selectSubDistrict(null);
                  }
                },
              ),
            ),

            // Sub-District Dropdown
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: addressModel.selectedSubDistrict,
                decoration: const InputDecoration(
                  labelText: 'Sub-District',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 3), // Compact styling
                ),
                items: addressModel.subDistricts
                    ?.map((subDistrict) => DropdownMenuItem(
                          value: subDistrict,
                          child: Text(subDistrict),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) addressController.selectSubDistrict(value);
                },
              ),
            ),

            // Tole Text Field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: formTextfield(
                controller: formController.toleController,
                icon: Icons.streetview,
                label: "Tole (Optional)",
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          Center(child: Text('Error loading address data: $err')),
    );
  }
}
