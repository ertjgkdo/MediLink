import 'package:medilink/features/search/presentation/controller/departments_search_delegate.dart';
import 'package:medilink/features/search/presentation/controller/doctor_search_delegate.dart';

import '../../../../utils/exporter.dart';

class searchBar extends ConsumerWidget {
  const searchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedFilter = ref.watch(searchFilterProvider);
    final filterController = ref.read(searchFilterProvider.notifier);

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await showSearch(
                context: context,
                delegate: selectedFilter == "Doctors"
                    ? DoctorsSearchDelegate()
                    : selectedFilter == "Departments"
                        ? DepartmentsSearchDelegate()
                        : HospitalSearchDelegate());
          },
          child: Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Icon(Icons.search, color: Colors.grey.shade600)),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Search $selectedFilter...",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: searchFilter(
                    onTapped: () => filterController.updateFilter("Doctors"),
                    icon: Icons.person_4_outlined,
                    filterLabel: "Search for Doctors",
                    isSelected: selectedFilter == "Doctors"),
              ),
              Expanded(
                child: searchFilter(
                    onTapped: () =>
                        filterController.updateFilter("Departments"),
                    icon: Icons.medical_information_outlined,
                    filterLabel: "Search for Department",
                    isSelected: selectedFilter == "Departments"),
              ),
              Expanded(
                child: searchFilter(
                    onTapped: () => filterController.updateFilter("Hospitals"),
                    icon: Icons.medical_services_outlined,
                    filterLabel: "Search for Hospitals",
                    isSelected: selectedFilter == "Hospitals"),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget searchFilter(
      {required Function() onTapped,
      required IconData icon,
      required String filterLabel,
      bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light grey shadow
              blurRadius: 6, // Soft shadow spread
              spreadRadius: 2, // Slight spread
              offset: const Offset(2, 3), // Shadow direction
            ),
          ],
          border: isSelected
              ? Border.all(color: Color.fromRGBO(255, 183, 77, 1))
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: GestureDetector(
          onTap: onTapped,
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  filterLabel,
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
              )
            ],
          )),
    );
  }
}
