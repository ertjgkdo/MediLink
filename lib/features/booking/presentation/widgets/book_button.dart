import '../../../../utils/exporter.dart';

class book_button extends StatelessWidget {
  book_button({super.key, required this.slotId});
  final slotId;
  final bookingRepo = BookingRepository();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final userId = await SecureStorage.getUserId();
          bookingRepo.book(slotId: slotId, userId: userId!);
        },
        child: Text("Book now"));
  }
}
