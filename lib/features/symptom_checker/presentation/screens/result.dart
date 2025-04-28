import 'package:medilink/utils/constants/disease_departments.dart';
import 'package:medilink/utils/constants/disease_description.dart';
import 'package:medilink/utils/exporter.dart';

class ResultPage extends ConsumerWidget {
  final List<ResultModel> results;

  const ResultPage({super.key, required this.results});

  @override
  Widget build(BuildContext context, ref) {
    final topexpanded = ref.watch(topDescriptionToggleProvider);
    final topPrediction = results.first;
    final otherPredictions = results.sublist(1);
    return Scaffold(
      body: Column(
        children: [
          const topbar_extended(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Results Based on Your Symptoms",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  const Text(
                    "Here are possible conditions matched to your input",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: lightprimary,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/screens/diagnostic.png",
                                height: 70,
                                width: 70,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Possible Condition:",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          topPrediction.condition,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              final toggleController = ref.read(
                                                  topDescriptionToggleProvider
                                                      .notifier);
                                              toggleController.state =
                                                  !toggleController.state;
                                            },
                                            icon: Icon(topexpanded
                                                ? Icons.arrow_drop_up_outlined
                                                : Icons
                                                    .arrow_drop_down_outlined)),
                                      )
                                    ],
                                  ),
                                  if (topexpanded)
                                    Text(
                                      diseaseDescriptions[
                                              topPrediction.condition] ??
                                          "No description available",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Confidence: ${topPrediction.confidence}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Suggested Department:${diseaseToDepartment[topPrediction.condition] ?? "N/A"}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Other Possible Conditions",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: otherPredictions.length,
                        itemBuilder: (context, index) {
                          final toggleStates = ref.watch(otherConditiontoggler);
                          final toggleController =
                              ref.read(otherConditiontoggler.notifier);
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color.fromRGBO(250, 237, 237, 1)),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        otherPredictions[index].condition,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Expanded(
                                        child: IconButton(
                                      onPressed: () {
                                        toggleController.toggle(index);
                                      },
                                      icon: Icon(toggleStates[index] == true
                                          ? Icons.arrow_drop_up_outlined
                                          : Icons.arrow_drop_down_outlined),
                                    ))
                                  ],
                                ),
                                if (toggleStates[index] == true)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        diseaseDescriptions[
                                                otherPredictions[index]
                                                    .condition] ??
                                            "No description available",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Suggested Department: ${diseaseToDepartment[otherPredictions[index].condition] ?? "N/A"}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(children: [
                                    Expanded(
                                      flex: 7,
                                      child: LinearProgressIndicator(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        minHeight: 15,
                                        value: double.parse(
                                                otherPredictions[index]
                                                    .confidence
                                                    .replaceAll('%', '')) /
                                            100,
                                        color: primary,
                                        backgroundColor: secondary,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            otherPredictions[index].confidence))
                                  ]),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SymptomCheckerPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(color: secondary))),
                        child: Text(
                          "Check Again",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: secondary),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                            child: Text("Browse Hospitals")),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
