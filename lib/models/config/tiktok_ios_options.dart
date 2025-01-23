class TikTokIosOptions {
  final bool disableTracking;
  final bool disableAutomaticTracking;
  final bool disableInstallTracking;
  final bool disableLaunchTracking;
  final bool disableRetentionTracking;
  final bool disablePaymentTracking;
  final bool disableAppTrackingDialog;
  final bool disableSKAdNetworkSupport;

  const TikTokIosOptions({
    this.disableTracking = false,
    this.disableAutomaticTracking = false,
    this.disableInstallTracking = false,
    this.disableLaunchTracking = false,
    this.disableRetentionTracking = false,
    this.disablePaymentTracking = false,
    this.disableAppTrackingDialog = false,
    this.disableSKAdNetworkSupport = false,
  });

  TikTokIosOptions copyWith({
    bool? disableTracking,
    bool? disableAutomaticTracking,
    bool? disableInstallTracking,
    bool? disableLaunchTracking,
    bool? disableRetentionTracking,
    bool? disablePaymentTracking,
    bool? disableAppTrackingDialog,
    bool? disableSKAdNetworkSupport,
  }) {
    return TikTokIosOptions(
      disableTracking: disableTracking ?? this.disableTracking,
      disableAutomaticTracking: disableAutomaticTracking ?? this.disableAutomaticTracking,
      disableInstallTracking: disableInstallTracking ?? this.disableInstallTracking,
      disableLaunchTracking: disableLaunchTracking ?? this.disableLaunchTracking,
      disableRetentionTracking: disableRetentionTracking ?? this.disableRetentionTracking,
      disablePaymentTracking: disablePaymentTracking ?? this.disablePaymentTracking,
      disableAppTrackingDialog: disableAppTrackingDialog ?? this.disableAppTrackingDialog,
      disableSKAdNetworkSupport: disableSKAdNetworkSupport ?? this.disableSKAdNetworkSupport,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'disableTracking': disableTracking,
      'disableAutomaticTracking': disableAutomaticTracking,
      'disableInstallTracking': disableInstallTracking,
      'disableLaunchTracking': disableLaunchTracking,
      'disableRetentionTracking': disableRetentionTracking,
      'disablePaymentTracking': disablePaymentTracking,
      'disableAppTrackingDialog': disableAppTrackingDialog,
      'disableSKAdNetworkSupport': disableSKAdNetworkSupport,
    };
  }

  @override
  bool operator ==(covariant TikTokIosOptions other) {
    if (identical(this, other)) return true;

    return other.disableTracking == disableTracking &&
        other.disableAutomaticTracking == disableAutomaticTracking &&
        other.disableInstallTracking == disableInstallTracking &&
        other.disableLaunchTracking == disableLaunchTracking &&
        other.disableRetentionTracking == disableRetentionTracking &&
        other.disablePaymentTracking == disablePaymentTracking &&
        other.disableAppTrackingDialog == disableAppTrackingDialog &&
        other.disableSKAdNetworkSupport == disableSKAdNetworkSupport;
  }

  @override
  int get hashCode {
    return disableTracking.hashCode ^
        disableAutomaticTracking.hashCode ^
        disableInstallTracking.hashCode ^
        disableLaunchTracking.hashCode ^
        disableRetentionTracking.hashCode ^
        disablePaymentTracking.hashCode ^
        disableAppTrackingDialog.hashCode ^
        disableSKAdNetworkSupport.hashCode;
  }
}
