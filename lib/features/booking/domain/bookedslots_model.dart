class BookedSlots {
  final String? id;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final bool? isBooked;
  final dynamic doctor;
  final dynamic user;
  BookedSlots(
      {this.id,
      this.date,
      this.startTime,
      this.endTime,
      this.isBooked,
      required this.doctor,
      required this.user});
}
