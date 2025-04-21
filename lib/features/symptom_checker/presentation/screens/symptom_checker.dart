import 'package:medilink/utils/exporter.dart';

class SymptomCheckerPage extends ConsumerWidget {
  const SymptomCheckerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedCategory = ref.watch(categoryFilterProvider);
    final selectedSymptoms = ref.watch(selectedSymptomProvider);
    final selectedController = ref.read(selectedSymptomProvider.notifier);
    final symptoms = symptomCategories[selectedCategory] ?? [];
    final isExpanded = ref.watch(symptomToggleProvider);
    return Scaffold(
      body: Column(
        children: [
          const top_bar(),
          Text(
            "Symptom Checker",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Icon(Icons.search, color: Colors.grey.shade600)),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Search symptoms",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 137, 123, 0.2),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          final toggleController =
                              ref.read(symptomToggleProvider.notifier);
                          toggleController.state = !toggleController.state;
                        },
                        icon: Icon(isExpanded
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down_outlined),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: const Text(
                        "Selected Symptoms",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ),
                if (isExpanded)
                  if (selectedSymptoms.isNotEmpty)
                    SizedBox(
                      height: 150, // Or adjust based on your UI
                      child: ListView.builder(
                        itemCount: selectedSymptoms.length,
                        itemBuilder: (context, index) {
                          final symptom = selectedSymptoms[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SymptomRow(symptom: symptom),
                          );
                        },
                      ),
                    )
                  else
                    Center(child: Text("No Symptoms Selected.")),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: ElevatedButton(
                    onPressed: () async {
                      final controller = SymptomCheckerController();
                      final results =
                          await controller.getPrediction(selectedSymptoms);
                      print(results);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultPage(
                                    results: results,
                                  )));
                    },
                    child: const Text("Check Symptoms"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              height: 50,
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: symptomCategories.keys.length,
                  itemBuilder: (context, index) {
                    final category = symptomCategories.keys.elementAt(index);
                    final isSelected = category == selectedCategory;

                    return GestureDetector(
                      onTap: () => ref
                          .read(categoryFilterProvider.notifier)
                          .updateFilter(category),
                      child: categories(
                          category: category, isSelected: isSelected),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 8, left: 25),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: const Text(
                      "?",
                      style: TextStyle(fontSize: 16),
                    )),
                const Expanded(
                  child: Text(
                    "Not sure what your Symptom is called?\nTry describing it or use the Search bar!",
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  final symptom = symptoms[index];
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SymptomRow(symptom: symptom));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categories({required String category, required bool isSelected}) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(1),
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          border: Border.all(color: isSelected ? highlight1 : secondary)),
      child: Row(
        children: [
          Image.asset(
            categoryIcons[category] ?? "assets/images/icons/general.jpg",
            height: 30,
            width: 30,
          ),
          Flexible(
            flex: 2,
            child: Text(
              category,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
