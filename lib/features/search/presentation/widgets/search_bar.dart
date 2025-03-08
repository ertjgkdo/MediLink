import '../../../../utils/exporter.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: GestureDetector(
            onTap: () async {
              // await showSearch(
              //     context: context, delegate: CustomSearchDelegate());
            },
            child: TextField(
              enabled: false,
              // controller: searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.search)),
                labelText: 'Search',
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              searchFilter(
                  onTapped: () {},
                  icon: Icons.person_4_outlined,
                  filterLabel: "Search for Doctors",
                  isSelected: true),
              searchFilter(
                  onTapped: () {},
                  icon: Icons.medical_information_outlined,
                  filterLabel: "Search for Department"),
              searchFilter(
                  onTapped: () {},
                  icon: Icons.medical_services_outlined,
                  filterLabel: "Search for Hospitals")
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
    return Expanded(
      child: Container(
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
                Icon(
                  icon,
                  size: 20,
                ),
                Flexible(
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
      ),
    );
  }
}
