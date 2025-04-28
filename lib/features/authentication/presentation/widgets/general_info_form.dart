import '../../../../utils/exporter.dart';

class GeneralInfoForm extends ConsumerWidget {
  const GeneralInfoForm({super.key, required this.formController});
  final SignUpController formController;
  @override
  Widget build(BuildContext context, ref) {
    // Dropdown values
    String? selectedGender;
    String? selectedBloodGroup;

    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Register your account",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: formTextfield(
                controller: formController.nameController,
                icon: Icons.person,
                label: "Full Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  if (RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Name cannot contain numbers';
                  }
                  return null;
                })),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextFormField(
                controller: formController.dobController,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          formController.dobController.text =
                              pickedDate.toString();
                        }
                      },
                    ),
                    labelText: "Date of Birth"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'DOB is required';
                  }
                  return null;
                })),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                    ),
                    items: genderOptions.map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child:
                            Text(gender, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formController.gender = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              // Blood Group Dropdown
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      decoration: const InputDecoration(
                        labelText: 'Blood Group',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                      ),
                      items: bloodGroupOptions.map((bloodGroup) {
                        return DropdownMenuItem<String>(
                          value: bloodGroup,
                          child: Text(bloodGroup,
                              style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        formController.bloodgroup = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required!';
                        }
                        return null;
                      },
                    )),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: formTextfield(
                controller: formController.phoneController,
                icon: Icons.phone,
                label: "Phone number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'[0-9]+$').hasMatch(value)) {
                    return 'Phone number must contain only numbers';
                  }
                  if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                })),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: formTextfield(
            controller: formController.emailController,
            icon: Icons.mail_outline,
            label: "Email (Optional)",
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
