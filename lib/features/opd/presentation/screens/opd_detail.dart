import '../../../../utils/exporter.dart';

class OpdDetail extends ConsumerWidget {
  final CardModel opdCard;
  const OpdDetail({super.key, required this.opdCard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opdRecordProvider = recordProvider(opdCard.id);
    final provider = ref.watch(opdRecordProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF2B3B5E),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const backButton(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    opdCard.hospital.name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("OPD NO:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("ISSUE DATE:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text("LAST VISIT:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(opdCard.opdNo,
                                style: const TextStyle(color: Colors.black)),
                            Text(opdCard.createdAt.toString(),
                                style: const TextStyle(color: Colors.black)),
                            Text(opdCard.records!.last.visitdate.toString(),
                                style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),

          // Bottom section
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.filter_list),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                      child: provider.when(
                    data: (records) {
                      return ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecordDetail(
                                          record: record,
                                        ))),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(record.doctor.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(record.department.name,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            )),
                                        const Divider(
                                            thickness: 1,
                                            color: Color(
                                                0xFFFFC107)), // highlight color
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: RecordDetailColumn(
                                                  label: "Visit Date",
                                                  value: record.visitdate
                                                      .toString()),
                                            ),
                                            Expanded(
                                              child: RecordDetailColumn(
                                                  label: "Time",
                                                  value: record.time),
                                            ),
                                            Expanded(
                                              child: RecordDetailColumn(
                                                  label: "Follow Up",
                                                  value: record.followup
                                                      .toString()),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Text(
                          "${error.toString()},/n ${stackTrace.toString()}");
                    },
                    loading: () => const CircularProgressIndicator(),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
