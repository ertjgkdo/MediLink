import 'package:medilink/utils/exporter.dart';

class HospitalPage extends ConsumerWidget {
  const HospitalPage({super.key, required this.hospital});
  final Hospital hospital;

  @override
  Widget build(BuildContext context, ref) {
    final hospProvider = ref.watch(singleHospitalProvider(hospital.id!));
    return Scaffold(
        body: hospProvider.when(
            data: (hospital) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //hospital description/detail container
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
                            Text(
                              hospital.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(hospital.address!),
                            Text(hospital.phone!),
                            Text(hospital.description!)
                          ],
                        ),
                      ),
                    ),
                    // //departments overview
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: const Text("Departments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))),
                          Expanded(
                            child: GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 1,
                                  childAspectRatio: 1,
                                ),
                                itemCount: hospital.departments!.length,
                                itemBuilder: (context, index) {
                                  final department =
                                      hospital.departments![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DepartmentPage(
                                                      department: department)));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://static.vecteezy.com/system/resources/previews/002/553/256/non_2x/heartbeat-cardiology-medical-and-health-care-line-style-icon-free-vector.jpg"),
                                                  fit: BoxFit.fill,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 214, 212, 212),
                                                      spreadRadius: 2,
                                                      blurRadius: 15,
                                                      offset: Offset(0, 8))
                                                ])),
                                        const SizedBox(height: 5),
                                        Text(
                                          department.name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
            error: (error, stackTrace) {
              return Column(
                children: [Text(error.toString()), Text(stackTrace.toString())],
              );
            },
            loading: () => const CircularProgressIndicator()));
  }
}
