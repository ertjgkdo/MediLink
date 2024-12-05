import 'package:medilink/utils/exporter.dart';

class AddressForm extends ConsumerWidget {
  const AddressForm({super.key, required this.formController});
  final SignUpController formController;
  @override
  Widget build(BuildContext context, ref) {
    Map<String, List<String>> provinces = {
      "Province No. 1": [
        "Bhojpur District",
        "Dhankuta District",
        "Ilam District",
        "Jhapa District",
        "Khotang District",
        "Morang District",
        "Okhaldhunga District",
        "Panchthar District",
        "Sankhuwasabha District",
        "Solukhumbu District",
        "Sunsari District",
        "Taplejung District",
        "Terhathum District",
        "Udayapur District"
      ],
      "Province No. 2": [
        "Saptari District",
        "Siraha District",
        "Dhanusa District",
        "Mahottari District",
        "Sarlahi District",
        "Bara District",
        "Parsa District",
        "Rautahat District"
      ],
      "Province No. 3": [
        "Sindhuli District",
        "Ramechhap District",
        "Dolakha District",
        "Bhaktapur District",
        "Dhading District",
        "Kathmandu District",
        "Kavrepalanchok District",
        "Lalitpur District",
        "Nuwakot District",
        "Rasuwa District",
        "Sindhupalchok District",
        "Chitwan District",
        "Makwanpur District"
      ],
      "Gandaki Pradesh": [
        "Baglung District",
        "Gorkha District",
        "Kaski District",
        "Lamjung District",
        "Manang District",
        "Mustang District",
        "Myagdi District",
        "Nawalpur District",
        "Parbat District",
        "Syangja District",
        "Tanahun District"
      ],
      "Province No. 5": [
        "Kapilvastu District",
        "Parasi District",
        "Rupandehi District",
        "Arghakhanchi District",
        "Gulmi District",
        "Palpa District",
        "Dang District",
        "Pyuthan District",
        "Rolpa District",
        "Eastern Rukum District",
        "Banke District",
        "Bardiya District"
      ],
      "Karnali Pradesh": [
        "Western Rukum District",
        "Salyan District",
        "Dolpa District",
        "Humla District",
        "Jumla District",
        "Kalikot District",
        "Mugu District",
        "Surkhet District",
        "Dailekh District",
        "Jajarkot District"
      ],
      "Sudurpashchim Pradesh": [
        "Kailali District",
        "Achham District",
        "Doti District",
        "Bajhang District",
        "Bajura District",
        "Kanchanpur District",
        "Dadeldhura District",
        "Baitadi District",
        "Darchula District"
      ]
    };

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 40, top: 60),
            child: Text(
              "Enter your Address",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: DropdownButtonFormField<String>(
            // value: selectedGender,
            decoration: const InputDecoration(
              labelText: 'Province',
              // Adds a border for better UI
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 3), // Compact styling
            ),
            items: [],
            //genderOptions.map((gender) {
            //   return DropdownMenuItem<String>(
            //     value: gender,
            //     child: Text(gender,
            //         style: TextStyle(fontSize: 14)
            //         ), // Compact text
            //   );
            // }).toList(),
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a province';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: DropdownButtonFormField<String>(
            // value: selectedGender,
            decoration: const InputDecoration(
              labelText: 'District',
              // Adds a border for better UI
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 3), // Compact styling
            ),
            items: [],
            //genderOptions.map((gender) {
            //   return DropdownMenuItem<String>(
            //     value: gender,
            //     child: Text(gender,
            //         style: TextStyle(fontSize: 14)
            //         ), // Compact text
            //   );
            // }).toList(),
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a district';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: DropdownButtonFormField<String>(
            // value: selectedGender,
            decoration: const InputDecoration(
              labelText: 'Sub-District',
              // Adds a border for better UI
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 3), // Compact styling
            ),
            items: [],
            //genderOptions.map((gender) {
            //   return DropdownMenuItem<String>(
            //     value: gender,
            //     child: Text(gender,
            //         style: TextStyle(fontSize: 14)
            //         ), // Compact text
            //   );
            // }).toList(),
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a sub-district';
              }
              return null;
            },
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: formTextfield(
                controller: formController.toleController,
                icon: Icons.streetview,
                label: "Tole (Optional)")),
      ],
    );
  }
}
