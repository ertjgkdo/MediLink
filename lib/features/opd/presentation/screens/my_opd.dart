import 'package:intl/intl.dart';
import 'package:medilink/utils/exporter.dart';

class MyOpd extends ConsumerWidget {
  const MyOpd({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder<String?>(
        future: SecureStorage.getUserId(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator()); // or any fallback UI
          }

          final String userId = snapshot.data!;
          final opdProvider = cardProvider(userId);
          final provider = ref.watch(opdProvider);
          return Scaffold(
            body: Column(children: [
              const top_bar(),
              Expanded(
                  child: provider.when(
                data: (cards) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];

                        DateTime? recentVisitDate =
                            card.records!.last.visitdate;
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OpdDetail(opdCard: card))),
                          child: Container(
                            margin: const EdgeInsets.all(30),
                            padding: const EdgeInsets.all(15),
                            height: 190,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/opd_card.png",
                                    ),
                                    fit: BoxFit.cover),
                                // color: secondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,

                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            // image: DecorationImage(
                                            //     image: AssetImage("assets/images/hospital/h1.png"),
                                            //     fit: BoxFit.cover),

                                            child: const Text("Logo"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  card.hospital.name,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "Issued On:",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            letterSpacing: 1),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                            color: secondary),
                                                        child: Text(
                                                          card.createdAt
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      1),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            "Last Visit:",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                      // SizedBox(
                                                      //   width: 5,
                                                      // ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                recentVisitDate !=
                                                                        null
                                                                    ? recentVisitDate
                                                                        .day
                                                                        .toString()
                                                                    : "N/A",
                                                                style: const TextStyle(
                                                                    color:
                                                                        highlight1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        36,
                                                                    letterSpacing:
                                                                        1),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    DateFormat(
                                                                            'MMMM')
                                                                        .format(
                                                                            recentVisitDate)
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                            highlight1,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            1),
                                                                  ),
                                                                  Text(
                                                                      recentVisitDate
                                                                          .year
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              highlight1,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              1))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              card.id,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                error: (error, stackTrace) {
                  return Text(
                      "${error.toString()},/n ${stackTrace.toString()}");
                },
                loading: () => const CircularProgressIndicator(),
              ))
              // )
            ]),
          );
        });
  }
}
