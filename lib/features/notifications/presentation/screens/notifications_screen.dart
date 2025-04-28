import 'package:medilink/features/notifications/presentation/screens/notification_settings.dart';
import 'package:medilink/utils/exporter.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(notificationProvider);

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: backButton()),
              SizedBox(
                width: 70,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationSettingsScreen()));
                    },
                    icon: Icon(Icons.settings)),
              )
            ],
          ),
          remindersAsync.when(
            data: (reminders) {
              if (reminders.isEmpty) {
                return const Center(child: Text("No notifications."));
              }

              return ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(reminder.title),
                      subtitle: Text(
                        'You have an appointment at${reminder.appointmentTime}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref
                              .read(notificationProvider.notifier)
                              .deleteReminder(reminder.id);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ],
      ),
    );
  }
}
