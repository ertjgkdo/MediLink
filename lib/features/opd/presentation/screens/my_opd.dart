import 'package:intl/intl.dart';
import 'package:medilink/utils/exporter.dart';

class MyOpd extends ConsumerWidget {
  const MyOpd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: SecureStorage.getUserId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final String userId = snapshot.data!;
        // print(userId);
        final opdProvider = cardProvider(userId);
        final provider = ref.watch(opdProvider);

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const top_bar(),
                Expanded(
                  child: provider.when(
                    data: (cards) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          DateTime? recentVisitDate =
                              card.records!.last.visitdate;

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpdDetail(opdCard: card),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              padding: const EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/opd_card.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: const Text("Logo"),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                card.hospital is Hospital
                                                    ? card.hospital.name
                                                    : "Unknown Hospital",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Issued On:",
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: secondary,
                                                    ),
                                                    child: Text(
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              card.createdAt),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          letterSpacing: 1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Last Visit:",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    letterSpacing: 1,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    recentVisitDate.day
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: highlight1,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 28,
                                                        letterSpacing: 1),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        DateFormat('MMMM')
                                                            .format(
                                                                recentVisitDate),
                                                        style: const TextStyle(
                                                            color: highlight1,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            letterSpacing: 1),
                                                      ),
                                                      Text(
                                                        recentVisitDate.year
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: highlight1,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            letterSpacing: 1),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            card.id,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              letterSpacing: 1,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(child: Text("Error: $error\n$stackTrace"));
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
