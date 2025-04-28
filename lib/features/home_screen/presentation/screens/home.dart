import 'package:medilink/utils/exporter.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPage = ref.watch(navBarSelectionProvider);
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: currentPage,
            children: [
              Visibility(
                visible: currentPage == 0,
                child: home(ref, context),
              ),
              Visibility(
                visible: currentPage == 1,
                child: Explore(),
              ),
              Visibility(
                visible: currentPage == 2,
                child: SymptomCheckerPage(),
              ),
              Visibility(
                visible: currentPage == 3,
                child: MyOpd(),
              ),
              Visibility(
                visible: currentPage == 4,
                child: Profile(),
              ),
            ],
          ),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: BottomBar(),
          )
        ],
      ),
    );
  }

  Widget home(WidgetRef ref, context) {
    final appointmentState = ref.watch(myAppointmentProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const top_bar(),
        const searchBar(),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.black)),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Appointments Easily!",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Find appointments with the doctor of your choice at your preferred time",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen()));
                        },
                        child: Text("Find Now"))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/home_img.jpg",
                ),
              )
            ],
          ),
        ),
        Text(
          "Upcoming Appointments",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Expanded(
          child: appointmentState.when(
            data: (slots) {
              final grouped =
                  ref.read(myAppointmentProvider.notifier).groupByDate(slots);
              final appointmentsForDay = grouped[DateTime(selectedDate.year,
                      selectedDate.month, selectedDate.day)] ??
                  [];
              return Column(
                children: [
                  Expanded(
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2040, 12, 31),
                      focusedDay: DateTime.now(),
                      onDaySelected: (selectedDay, focusedDay) {
                        ref.read(selectedDateProvider.notifier).state =
                            selectedDay;
                      },
                      eventLoader: (day) =>
                          grouped[DateTime(day.year, day.month, day.day)] ?? [],
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          if (events.isEmpty) return null;
                          return Positioned(
                            bottom: 1,
                            child: Container(
                              width: 20,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: highlight1,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: appointmentsForDay.isEmpty
                          ? Center(
                              child: Text("No appointments on this day"),
                            )
                          : ListView.builder(
                              itemCount: appointmentsForDay.length,
                              itemBuilder: (context, index) {
                                final slot = appointmentsForDay[index];
                                return ListTile(
                                    leading: Icon(Icons.calendar_today),
                                    title: Text(
                                        "${slot.startTime}-${slot.endTime}"),
                                    subtitle: Text(
                                        "Doctor: ${slot.doctor["name"] ?? "Unknown"}"));
                              }))
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }
}
