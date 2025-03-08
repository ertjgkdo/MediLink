import 'package:medilink/utils/exporter.dart';

class DepartmentPage extends ConsumerWidget {
  const DepartmentPage({super.key, required this.department});
  final Department department;
  @override
  Widget build(BuildContext context, ref) {
    final depProvider = ref.watch(singleDepProvider(department.id!));
    return Scaffold(
        body: depProvider.when(
            data: (department) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topbar_extended(),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/hospital/h1.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Text(department.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              department.description!,
                              textAlign: TextAlign.center,
                            ),
                          )
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
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 2),
                              child: const Text("Doctors",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))),
                          Expanded(
                            // margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final doctor = department.doctors![index];
                                  return Consumer(
                                      builder: (context, ref, child) {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorPage(
                                                        doctor: doctor)));
                                      },
                                      leading: doctor.image != null &&
                                              doctor.image!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(doctor.image!),
                                              radius: 24,
                                            )
                                          : const CircleAvatar(
                                              radius: 24,
                                              child:
                                                  Icon(Icons.person, size: 30),
                                            ),
                                      title: Text(doctor.name!),
                                      subtitle: Text(doctor.title!),
                                      trailing: InkWell(
                                        onTap: () {
                                          // Handle the click event
                                          print(
                                              "See availability clicked for ${doctor.name}");
                                        },
                                        child: const Text(
                                          "See availability",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemCount: department.doctors!.length,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              );
            },
            error: (error, stackTrace) {
              return Column(
                children: [Text(error.toString()), Text(stackTrace.toString())],
              );
            },
            loading: () => const CircularProgressIndicator()));
  }
}
