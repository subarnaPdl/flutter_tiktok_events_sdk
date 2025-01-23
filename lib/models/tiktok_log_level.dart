enum TikTokLogLevel {
  none('none'), // NONE - Android / TikTokLogLevelSuppress - iOS
  info('info'), // INFO - Android / TikTokLogLevelInfo - iOS
  warn('warn'), // WARN - Android / TikTokLogLevelWarn - iOS
  debug('debug'), // DEBUG - Android / TikTokLogLevelDebug - iOS
  verbose('verbose'); // VERBOSE - Android / TikTokLogLevelVerbose no iOS

  final String name;
  const TikTokLogLevel(this.name);
}
