import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medilink/utils/exporter.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration =
        ref.watch(reminderDurationProvider); // Watch the duration state

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: backButton()),
              SizedBox(width: 70),
              Expanded(
                  flex: 5,
                  child: Text(
                    "Notification Settings",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reminder Duration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Reminder:'),
                    Text('${duration.inHours} hours'),
                  ],
                ),
                Slider(
                  min: 0,
                  max: 48, // Allow setting up to 48 hours
                  divisions: 48, // Divisions for each hour
                  label: '${duration.inHours} hours',
                  value: duration.inHours.toDouble(),
                  onChanged: (value) {
                    // Update duration
                    final newDuration = Duration(hours: value.toInt());
                    ref
                        .read(reminderDurationProvider.notifier)
                        .setDuration(newDuration);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Save settings (duration is saved automatically when changed)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reminder duration saved!')),
                    );
                  },
                  child: const Text('Save Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
