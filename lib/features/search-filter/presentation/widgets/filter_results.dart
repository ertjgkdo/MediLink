import 'package:medilink/utils/exporter.dart';

class FilterResults extends ConsumerWidget {
  const FilterResults({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filterAsync = ref.watch(filteredProvider);
    return Column(
      children: [
        Column(
          children: [
            filterAsync.when(
                data: (slots) {
                  return ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      final slot = slots[index];
                      return ListTile(
                        title: Text("${slot.startTime} - ${slot.endTime}"),
                      );
                    },
                  );
                },
                loading: () => CircularProgressIndicator(),
                error: (e, st) =>
                    Text("")), // unlikely if you handle errors manually
          ],
        )
      ],
    );
  }
}
