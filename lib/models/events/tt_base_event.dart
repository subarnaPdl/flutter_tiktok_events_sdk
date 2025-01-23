import 'package:tiktok_events_sdk/models/events/tt_event_type.dart';

abstract class TTBaseEvent {
  final TTEventType eventType;
  final Map<String, dynamic>? properties;
  final String? eventId;
  final String eventName;

  TTBaseEvent({
    this.eventType = TTEventType.none,
    this.properties,
    this.eventId,
    required this.eventName,
  });

  Map<String, dynamic> toJson() => {
        'event_type_name': eventType.name,
        'parameters': properties,
        'event_id': eventId,
        'event_name': eventName,
      };
}
