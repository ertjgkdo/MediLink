import 'package:medilink/utils/exporter.dart';

class FilterController extends AsyncNotifier<List<Slot>> {
  final filterForm = GlobalKey<FormState>();
  final TextEditingController timeSlotController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  late final String? selectedHospitalId;
  late final String? selectedDepartmentId;
  late final String? selectedDoctorId;
  late final String? selectedTimeSlot;
  late final String? selectedAmPm;

  @override
  List<Slot> build() {
    final selectedHospital = ref.watch(selectedHospitalIdProvider);
    final selectedDepartment = ref.watch(selectedDepartmentIdProvider);
    final selectedDoctor = ref.watch(selectedDoctorIdProvider);
    final selectedTime = ref.watch(selectedTimeSlotProvider);
    final selectedAm = ref.watch(selectedAmPmProvider);

    selectedHospitalId = selectedHospital;
    selectedDepartmentId = selectedDepartment;
    selectedDoctorId = selectedDoctor;
    selectedTimeSlot = selectedTime;
    selectedAmPm = selectedAm;

    return [];
  }

  Future<bool> filterSlots() async {
    final selectedHospital = ref.read(selectedHospitalIdProvider);
    final selectedDepartment = ref.read(selectedDepartmentIdProvider);
    final selectedDoctor = ref.read(selectedDoctorIdProvider);
    final selectedTimeSlot = ref.read(selectedTimeSlotProvider);

    if (selectedHospital == null ||
        selectedDepartment == null ||
        selectedDoctor == null ||
        dateController.text.isEmpty ||
        selectedTimeSlot == null ||
        selectedTimeSlot.isEmpty) {
      return false;
    }

    final repo = SlotRepository();

    state = const AsyncValue.loading();

    try {
      final filteredSlots = await repo.getSlot(
        hospital: selectedHospital,
        department: selectedDepartment,
        date: DateTime.parse(dateController.text),
        doctor: selectedDoctor,
        timeslot: selectedTimeSlot,
      );
      state = AsyncValue.data(filteredSlots);
      return true;
    } catch (e) {
      state = AsyncValue.data([]);
      return false;
    }
  }
}
