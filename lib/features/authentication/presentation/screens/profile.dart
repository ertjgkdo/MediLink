import 'package:intl/intl.dart';

import 'package:medilink/utils/exporter.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final signoutController = ref.read(signoutProvider.notifier);
    final provider = ref.watch(profileProvider);
    final profileController = ref.read(profileProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "My Profile",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications_outlined)),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                signoutController.signout(context: context);
                              },
                              icon: Icon(Icons.logout)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          provider.when(
              data: (patient) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/hospital/h1.png"))
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
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          patient.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            ref.invalidate(profileProvider);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEditForm(
                                          patient: patient,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 137, 123, 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          child: Text("Edit Profile")),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          infoRow(
                              icon: Icons.calendar_today_outlined,
                              label: "DOB",
                              value: DateFormat('yyyy-MM-dd')
                                  .format(patient.dob!)
                                  .toString()),
                          infoRow(
                              icon: Icons.person_outline,
                              label: "Gender",
                              value: patient.gender!),
                          infoRow(
                              icon: Icons.water_drop_outlined,
                              label: "Blood Group",
                              value: patient.bloodGroup!),
                          infoRow(
                              icon: Icons.location_on_outlined,
                              label: "Address",
                              value: patient.address != ""
                                  ? patient.address!
                                  : "N/A"),
                          infoRow(
                              icon: Icons.phone_outlined,
                              label: "Phone",
                              value: patient.phone),
                          infoRow(
                              icon: Icons.mail,
                              label: "Mail",
                              value:
                                  patient.email != "" ? patient.email! : "N/A")
                        ],
                      )
                    ]);
              },
              error: (error, stackTrace) => Center(
                    child: Column(
                      children: [
                        Text(error.toString()),
                        Text(stackTrace.toString()),
                      ],
                    ),
                  ),
              loading: () => CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget infoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(child: Icon(icon)),
                Expanded(
                    child: Text(
                  label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromRGBO(102, 102, 102, 1)))),
              child: Text(value,
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
