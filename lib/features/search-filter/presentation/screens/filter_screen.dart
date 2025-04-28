import 'package:medilink/features/search-filter/presentation/widgets/filter_results.dart';
import 'package:medilink/utils/exporter.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final dataAsync = ref.watch(filterOptionsProvider);

    final selectedHospitalId = ref.watch(selectedHospitalIdProvider);
    final selectedDepartmentId = ref.watch(selectedDepartmentIdProvider);
    final selectedDoctorId = ref.watch(selectedDoctorIdProvider);
    final selectedAmPm = ref.watch(selectedAmPmProvider);

    return Scaffold(
        body: Column(children: [
      topbar_extended(),
      dataAsync.when(
        data: (data) {
          final filterController = ref.read(filteredProvider.notifier);
          return Padding(
            padding: EdgeInsets.all(25),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filters"),
                    TextButton(
                        onPressed: () {
                          ref.read(selectedHospitalIdProvider.notifier).state =
                              null;
                          ref
                              .read(selectedDepartmentIdProvider.notifier)
                              .state = null;
                          ref.read(selectedDoctorIdProvider.notifier).state =
                              null;
                          ref.read(selectedTimeSlotProvider.notifier).state =
                              '';
                          ref.read(selectedAmPmProvider.notifier).state = '';
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: highlight1),
                        ))
                  ],
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Hospital',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedHospitalId,
                  items: data
                      .map((hospital) => DropdownMenuItem<String>(
                            value: hospital.id,
                            child: Text(hospital.name!),
                          ))
                      .toList(),
                  onChanged: (value) {
                    ref.read(selectedHospitalIdProvider.notifier).state = value;
                    ref.read(selectedDepartmentIdProvider.notifier).state =
                        null;
                    ref.read(selectedDoctorIdProvider.notifier).state = null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedDepartmentId,
                  items: selectedHospitalId != null
                      ? data
                          .firstWhere(
                              (hospital) => hospital.id == selectedHospitalId)
                          .departments!
                          .map((department) => DropdownMenuItem<String>(
                                value: department.id,
                                child: Text(department.name!),
                              ))
                          .toList()
                      : [],
                  onChanged: (value) {
                    ref.read(selectedDepartmentIdProvider.notifier).state =
                        value;
                    ref.read(selectedDoctorIdProvider.notifier).state = null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Doctor',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedDoctorId,
                  items: selectedDepartmentId != null
                      ? data
                          .firstWhere(
                              (hospital) => hospital.id == selectedHospitalId)
                          .departments!
                          .firstWhere((department) =>
                              department.id == selectedDepartmentId)
                          .doctors!
                          .map((doctor) => DropdownMenuItem<String>(
                                value: doctor.id,
                                child: Text(doctor.name!),
                              ))
                          .toList()
                      : [],
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: filterController.dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          filterController.dateController.text =
                              pickedDate.toString();
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Time slot',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(),
                        items: ['AM', 'PM']
                            .map((period) => DropdownMenuItem(
                                  value: period,
                                  child: Text(period),
                                ))
                            .toList(),
                        onChanged: (value) {
                          ref.read(selectedAmPmProvider.notifier).state = value;
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () async {
                    final success = await filterController.filterSlots();
                    if (!success) {
                      // show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Something went wrong. Please try again.')),
                      );
                    }
                  },
                  child: const Text('Apply'),
                ),
                const Divider(height: 40),
                const SizedBox(height: 10),
                const FilterResults(),
              ],
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Text(error.toString());
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ]));
  }
}
