import '../../../../utils/exporter.dart';

class GeneralInfoForm extends ConsumerWidget {
  const GeneralInfoForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController dobController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    // Dropdown values
    String? selectedGender;
    String? selectedBloodGroup;

    // Gender and blood group options
    final List<String> genderOptions = ['Male', 'Female', 'Other'];
    final List<String> bloodGroupOptions = [
      'A+',
      'A-',
      'B+',
      'B-',
      'O+',
      'O-',
      'AB+',
      'AB-'
    ];
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 40, top: 40),
            child: Text(
              "Register your account",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: formTextfield(
                controller: nameController,
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
                controller: dobController,
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
                          dobController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
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
                  padding: const EdgeInsets.only(
                      right: 5), // Adds spacing between the dropdowns
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      // Adds a border for better UI
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 3), // Compact styling
                    ),
                    items: genderOptions.map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender,
                            style:
                                const TextStyle(fontSize: 14)), // Compact text
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Handle selection
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
                    padding: const EdgeInsets.only(
                        left: 5.0), // Adds spacing between the dropdowns
                    child: DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      decoration: const InputDecoration(
                        labelText: 'Blood Group',
                        // Adds a border for better UI
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 3), // Compact styling
                      ),
                      items: bloodGroupOptions.map((bloodGroup) {
                        return DropdownMenuItem<String>(
                          value: bloodGroup,
                          child: Text(bloodGroup,
                              style: const TextStyle(
                                  fontSize: 14)), // Compact text
                        );
                      }).toList(),
                      onChanged: (value) {
                        // Handle selection
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
                controller: phoneController,
                icon: Icons.phone,
                label: "Phone number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'[0-9]+$').hasMatch(value)) {
                    return 'Phone number must contain only numbers';
                  }
                  return null;
                })),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: formTextfield(
            controller: emailController,
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
