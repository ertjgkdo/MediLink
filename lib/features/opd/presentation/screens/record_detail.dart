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
                                    record.doctor.name,
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
                          value: record.visitdate.toString(),
                        )),
                        Expanded(
                          child: RecordDetailColumn(
                              label: "Time", value: record.time),
                        ),
                        Expanded(
                          child: RecordDetailColumn(
                              label: "Follow Up",
                              value: record.followup.toString()),
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
                        const Text(
                          "Chief Complaint: ",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: secondary),
                        ),
                        Text(
                          record.chiefcomplain!,
                          style:
                              const TextStyle(fontSize: 12, letterSpacing: 0.5),
                        )
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
                      children: [
                        const Text(
                          "Examination",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: secondary),
                        ),
                        Text(
                          record.examination!,
                          style:
                              const TextStyle(fontSize: 12, letterSpacing: 0.5),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(162, 167, 166, 1),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      const Text(
                        "Diagnosis",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            letterSpacing: 0.5,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: secondary),
                      ),
                      Text(
                        record.diagnosis!,
                        style:
                            const TextStyle(fontSize: 12, letterSpacing: 0.5),
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: borderColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Prescription",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: secondary),
                  ),
                  ListView.builder(
                    itemCount: record.prescription?.length,
                    itemBuilder: (context, index) {
                      final prescription = record.prescription![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                prescription.medicine!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                prescription.duration!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            prescription.instruction!,
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
              style: const TextStyle(fontWeight: FontWeight.bold, height: 1.7),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(height: 1.7),
            ),
          )
        ],
      ),
    );
  }
}
