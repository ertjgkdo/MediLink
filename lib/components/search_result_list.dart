import '../utils/exporter.dart';

class searchResultList extends StatelessWidget {
  const searchResultList({
    super.key,
    required this.results,
  });

  final List results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        print(results.length);
        return ListTile(
          title: Text(
            item.name ?? "Unknown",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 59, 66, 83),
            ),
          ), // Check dynamically
          subtitle: item is Doctor
              ? Text("Specialty: ${item.title}")
              : item is Department
                  ? Text("${item.hospital.name}")
                  : item is Hospital
                      ? Text("Location: ${item.address}")
                      : null,
          leading: item is Doctor || item is Hospital
              ? item.image != null
                  ? const Image(
                      image: const AssetImage("assets/images/hospital/h1.png"))
                  : const Icon(Icons.person)
              : null,
          onTap: () {
            if (item is Doctor) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorPage(doctor: item)));
            }
            if (item is Hospital) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospitalPage(hospital: item)));
            }
            if (item is Department) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DepartmentPage(department: item)));
            }
            print("Selected: ${item.name ?? item.title}");
          },
        );
      },
    );
  }
}
