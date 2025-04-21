import 'package:intl/intl.dart';
import 'package:medilink/utils/exporter.dart';

class RecordDetail extends ConsumerWidget {
  final RecordModel record;
  const RecordDetail({super.key, required this.record});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: backButton()),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Dr. ${record.doctor.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    record.department.name,
                                    style: const TextStyle(
                                        color: Color(0xFF1A2B50), fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: RecordDetailColumn(
                          label: "Visit Date",
                          value: DateFormat('yyyy-MM-dd')
                              .format(record.visitdate)
                              .toString(),
                        )),
                        Expanded(
                          child: RecordDetailColumn(
                              label: "Time", value: record.time),
                        ),
                        Expanded(
                          child: RecordDetailColumn(
                              label: "Follow Up",
                              value: DateFormat('yyyy-MM-dd')
                                  .format(record.followup!)
                                  .toString()),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            "Chief Complaint: ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                letterSpacing: 0.5,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: secondary),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            record.chiefcomplain!,
                            style: const TextStyle(
                                fontSize: 12, letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Vital Signs",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: secondary),
                        ),
                        vitalsRow(label: "BP:", value: record.vitals!.bp!),
                        vitalsRow(label: "Temp:", value: record.vitals!.temp!),
                        vitalsRow(label: "Wt:", value: record.vitals!.wt!),
                        vitalsRow(label: "Ht:", value: record.vitals!.ht!)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: borderColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            "Examination",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                letterSpacing: 0.5,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: secondary),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            record.examination!,
                            style: const TextStyle(
                                fontSize: 12, letterSpacing: 0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(162, 167, 166, 1),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          "Diagnosis",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: secondary),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          record.diagnosis!,
                          style:
                              const TextStyle(fontSize: 12, letterSpacing: 0.5),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: borderColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      "Prescription",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          letterSpacing: 0.5,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: secondary),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: record.prescription?.length,
                      itemBuilder: (context, index) {
                        if (record.prescription == null) {
                          return Center(
                              child: Text("No prescriptions provided"));
                        }
                        final prescription = record.prescription![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  prescription.medicine,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  prescription.duration,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              prescription.instruction ??
                                  "No specific instruction provided",
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Color.fromRGBO(162, 167, 166, 1),
                              thickness: 1,
                              height: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget vitalsRow({required String label, required String value}) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, height: 1),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(height: 1),
            ),
          )
        ],
      ),
    );
  }
}
