class TikTokAndroidOptions {
  final bool disableAutoStart;
  final bool disableAutoEvents;
  final bool disableInstallLogging;
  final bool disableLaunchLogging;
  final bool disableRetentionLogging;
  final bool enableAutoIapTrack;
  final bool disableAdvertiserIDCollection;

  const TikTokAndroidOptions({
    this.disableAutoStart = false,
    this.disableAutoEvents = false,
    this.disableInstallLogging = false,
    this.disableLaunchLogging = false,
    this.disableRetentionLogging = false,
    this.enableAutoIapTrack = false,
    this.disableAdvertiserIDCollection = false,
  });

  TikTokAndroidOptions copyWith({
    bool? disableAutoStart,
    bool? disableAutoEvents,
    bool? disableInstallLogging,
    bool? disableLaunchLogging,
    bool? disableRetentionLogging,
    bool? enableAutoIapTrack,
    bool? disableAdvertiserIDCollection,
  }) {
    return TikTokAndroidOptions(
      disableAutoStart: disableAutoStart ?? this.disableAutoStart,
      disableAutoEvents: disableAutoEvents ?? this.disableAutoEvents,
      disableInstallLogging: disableInstallLogging ?? this.disableInstallLogging,
      disableLaunchLogging: disableLaunchLogging ?? this.disableLaunchLogging,
      disableRetentionLogging: disableRetentionLogging ?? this.disableRetentionLogging,
      enableAutoIapTrack: enableAutoIapTrack ?? this.enableAutoIapTrack,
      disableAdvertiserIDCollection: disableAdvertiserIDCollection ?? this.disableAdvertiserIDCollection,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'disableAutoStart': disableAutoStart,
      'disableAutoEvents': disableAutoEvents,
      'disableInstallLogging': disableInstallLogging,
      'disableLaunchLogging': disableLaunchLogging,
      'disableRetentionLogging': disableRetentionLogging,
      'enableAutoIapTrack': enableAutoIapTrack,
      'disableAdvertiserIDCollection': disableAdvertiserIDCollection,
    };
  }

  @override
  bool operator ==(covariant TikTokAndroidOptions other) {
    if (identical(this, other)) return true;

    return other.disableAutoStart == disableAutoStart &&
        other.disableAutoEvents == disableAutoEvents &&
        other.disableInstallLogging == disableInstallLogging &&
        other.disableLaunchLogging == disableLaunchLogging &&
        other.disableRetentionLogging == disableRetentionLogging &&
        other.enableAutoIapTrack == enableAutoIapTrack &&
        other.disableAdvertiserIDCollection == disableAdvertiserIDCollection;
  }

  @override
  int get hashCode {
    return disableAutoStart.hashCode ^
        disableAutoEvents.hashCode ^
        disableInstallLogging.hashCode ^
        disableLaunchLogging.hashCode ^
        disableRetentionLogging.hashCode ^
        enableAutoIapTrack.hashCode ^
        disableAdvertiserIDCollection.hashCode;
  }
}
