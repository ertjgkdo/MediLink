import 'package:flutter/material.dart';
import 'package:medilink/features/hospital_directory/state/state.dart';
import 'package:medilink/utils/exporter.dart';

class Explore extends ConsumerWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final hospProvider = ref.watch(hospitalProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const top_bar(),
          const searchBar(),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                "Browse Hospitals",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              )),
          Expanded(
              child: hospProvider.when(
                  data: (hospitals) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row

                        mainAxisSpacing: 10,
                        childAspectRatio: 1, // Square shape
                      ),
                      itemCount: hospitals.length,
                      itemBuilder: (context, index) {
                        final hospital = hospitals[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HospitalPage(hospital: hospital)));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 10),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 2, right: 2, top: 2),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/hospital/h1.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              child: Text(
                                            hospital.name!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            hospital.address!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            hospital.phone!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    );
                  },
                  error: (error, StackTrace) => Container(
                        child: Column(
                          children: [
                            Text(error.toString()),
                            Text(StackTrace.toString()),
                          ],
                        ),
                      ),
                  loading: () => const CircularProgressIndicator()))
        ],
      ),
    );
  }
}
