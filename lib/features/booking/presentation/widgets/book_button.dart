import 'package:medilink/utils/exporter.dart';

class BookButton extends StatelessWidget {
  final WidgetRef ref;
  final Slot slot;
  final String doctorId;

  BookButton({
    super.key,
    required this.slot,
    required this.ref,
    required this.doctorId,
  });

  final bookingRepo = BookingRepository();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Confirm Booking"),
                  content:
                      Text('Are you sure you want to book this appointment?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("Cancel")),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Confirm"),
                    ),
                  ],
                ));

        if (confirm == true) {
          final userId = await SecureStorage.getUserId();
          if (userId == null) return;

          // Booking the appointment
          final appointment = await bookingRepo.book(
            slotId: slot.id!,
            userId: userId,
          );

          // 2. Invalidate providers if needed
          ref.invalidate(slotDocProvider(doctorId));

          // 3. Pick user's reminder preference (this is just an example duration)
          final reminderDuration =
              ref.read(reminderDurationProvider); // like Duration(hours: 24)

          // 4. Schedule the reminder notification
          ref.read(notificationProvider.notifier).scheduleReminder(
                id: appointment.id.hashCode,
                title: "Appointment Reminder",
                body: "You have an appointment at ${slot.startTime}",
                appointmentTime: slot.date!,
                remindBefore: reminderDuration,
              );
          // 5. Show some confirmation
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Booking Successful 🎉"),
              content: const Text(
                  "Your appointment has been booked and a reminder has been set!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      },
      child: Text("Book now"),
    );
  }
}
