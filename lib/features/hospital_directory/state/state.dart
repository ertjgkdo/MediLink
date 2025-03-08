import 'package:medilink/features/hospital_directory/data/single_object_controller.dart';
import 'package:medilink/utils/exporter.dart';

//provider for list of all hospitals
final hospitalProvider = AsyncNotifierProvider.autoDispose<
    AllObjectsController<Hospital>, List<Hospital>>(
  () => AllObjectsController(fetchFunction: HospitalRepository().getHospList),
);

//provider for a single hospital
final singleHospitalProvider = AutoDisposeAsyncNotifierProvider.family<
    SingleObjectController<Hospital>, Hospital, String>(
  () => SingleObjectController<Hospital>(
    fetchFunction: (id) => HospitalRepository().getHospitalbyId(id: id),
  ),
);

//provider for list of all departments
final depProvider = AsyncNotifierProvider.autoDispose<
    AllObjectsController<Department>, List<Department>>(
  () => AllObjectsController(fetchFunction: DepartmentRepository().getDepList),
);

//provider for a single department
final singleDepProvider = AutoDisposeAsyncNotifierProvider.family<
    SingleObjectController<Department>, Department, String>(
  () => SingleObjectController<Department>(
    fetchFunction: (id) => DepartmentRepository().getDepbyId(id: id),
  ),
);

//provider for list of all doctors
final doctorProvider = AsyncNotifierProvider.autoDispose<
    AllObjectsController<Doctor>, List<Doctor>>(
  () => AllObjectsController(fetchFunction: DoctorRepository().getDocList),
);

//provider for list of all schedules
final scheduleProvider = AsyncNotifierProvider.autoDispose<
    AllObjectsController<Schedule>, List<Schedule>>(
  () => AllObjectsController(fetchFunction: SchedRepository().getSchedList),
);

//provider for a single slot retrieved for a doctor
final slotDocProvider = AutoDisposeAsyncNotifierProvider.family<
        SingleObjectController<List<Slot>>, List<Slot>, String>(
    () => SingleObjectController<List<Slot>>(
        fetchFunction: (id) => SlotRepository().getSlotbyDocId(id: id)));

//provider for list of all slots
final slotProvider =
    AsyncNotifierProvider.autoDispose<AllObjectsController<Slot>, List<Slot>>(
  () => AllObjectsController(fetchFunction: SlotRepository().getSlotList),
);
