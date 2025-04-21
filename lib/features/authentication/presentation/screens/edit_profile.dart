import 'package:medilink/features/authentication/presentation/screens/password_change.dart';
import 'package:medilink/utils/exporter.dart';

class ProfileEditForm extends ConsumerWidget {
  final Patient patient;
  const ProfileEditForm({super.key, required this.patient});
  @override
  Widget build(BuildContext context, ref) {
    final editController = ref.read((editFormProvider(patient)).notifier);
    final formState = ref.watch(editFormProvider(patient));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15, left: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(),
                ElevatedButton(
                  onPressed: () {
                    editController.updateProfile(context: context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text("Save"),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage("assets/images/hospital/h1.png"))
                // user.pfp != null
                //     ? DecorationImage(
                //         image: NetworkImage(
                //         user.pfp!,
                //       ))
                //     : null
                ),
            // child: user.pfp == null
            //     ? const Icon(
            //         Icons.person_2_outlined,
            //         size: 70,
            //       )
            //     : null
          ),
          Form(
            key: editController.editFormKey,
            child: Column(
              children: [
                editInfoRow(
                    controller: editController.nameController,
                    label: "Name",
                    onChanged: (value) {
                      editController.addInfo(name: value);
                    }),
                editInfoRow(
                    controller: editController.dobController,
                    label: "DOB",
                    initialDate: formState.dob,
                    context: context,
                    icon: Icons.calendar_today_outlined,
                    onChanged: (value) {
                      editController.addInfo(dob: DateTime.parse(value!));
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(children: [
                    Expanded(
                      child: Text("Gender",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          height: 34,
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            value: formState.gender,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            items: genderOptions.map((gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender,
                                    style: const TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                editController.addInfo(gender: value);
                              }
                            },
                          )),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(children: [
                    Expanded(
                      child: Text("Blood Group",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 34,
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          value: formState.bloodGroup, // ✅ prefill value
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          items: bloodGroupOptions.map((bloodGroup) {
                            return DropdownMenuItem<String>(
                              value: bloodGroup,
                              child: Text(bloodGroup,
                                  style: const TextStyle(fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              editController.addInfo(bloodGroup: value);
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                editInfoRow(
                    controller: editController.addressController,
                    label: "Address",
                    onChanged: (value) {
                      editController.addInfo(address: value);
                    }),
                editInfoRow(
                    controller: editController.phoneController,
                    label: "Phone",
                    onChanged: (value) {
                      editController.addInfo(phone: value);
                    }),
                editInfoRow(
                    controller: editController.mailController,
                    label: "Mail",
                    onChanged: (value) {
                      editController.addInfo(email: value);
                    })
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: primary),
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }

  Widget editInfoRow(
      {BuildContext? context,
      DateTime? initialDate,
      IconData? icon,
      required String label,
      required TextEditingController controller,
      required void Function(String?) onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 200,
              height: 34,
              child: icon != null
                  ? TextFormField(
                      controller: controller,
                      onSaved: onChanged,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context!,
                                initialDate: initialDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                String formatted = pickedDate
                                    .toIso8601String()
                                    .split('T')[0]; // yyyy-MM-dd
                                controller.text = formatted;
                                onChanged(formatted);
                              }
                            },
                            icon: Icon(
                              icon,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ))
                  : TextFormField(
                      controller: controller,
                      onChanged: onChanged,
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
            ),
          ),
        ],
      ),
    );
  }
}
