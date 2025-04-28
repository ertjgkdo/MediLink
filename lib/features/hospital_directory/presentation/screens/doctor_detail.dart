import 'package:medilink/utils/exporter.dart';

class DoctorPage extends ConsumerWidget {
  const DoctorPage({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context, ref) {
    final slotsProvider = ref.watch(slotDocProvider(doctor.id!));
    return Scaffold(
        body: Column(
      children: [
        const topbar_extended(),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/hospital/h1.png"),
                          fit: BoxFit.cover)),
                ),
                Text(
                  doctor.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(doctor.title!),
                Text(doctor.email!),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                    child: const Text("Available Appointment Slots",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15))),
                Expanded(
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: slotsProvider.when(
                        data: (slots) {
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return Consumer(builder: (context, ref, child) {
                                final slot = slots[index];
                                return ListTile(
                                    // onTap: () {},
                                    leading: const Icon(
                                      Icons.access_time,
                                      color: Colors.blue,
                                    ),
                                    title: Text(
                                        "${slot.startTime}-${slot.endTime}"),
                                    subtitle: Text(slot.date.toString()),
                                    trailing: BookButton(
                                      slot: slot,
                                      doctorId: doctor.id!,
                                      ref: ref,
                                    ));
                              });
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: slots.length,
                          );
                        },
                        error: (error, stackTrace) {
                          return Column(
                            children: [
                              Text(error.toString()),
                              Text(stackTrace.toString())
                            ],
                          );
                        },
                        loading: () => const CircularProgressIndicator()),
                  ),
                ),
              ],
            ))
      ],
    ));
  }
}
