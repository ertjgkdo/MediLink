import '../../../../utils/exporter.dart';

class book_button extends StatelessWidget {
  final WidgetRef ref;

  book_button(
      {super.key,
      required this.slotId,
      required this.ref,
      required this.doctorId});

  final String? slotId;
  final String doctorId;
  final bookingRepo = BookingRepository();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final userId = await SecureStorage.getUserId();
          bookingRepo.book(slotId: slotId!, userId: userId!);
          ref.invalidate(slotDocProvider(doctorId));
        },
        child: Text("Book now"));
  }
}
