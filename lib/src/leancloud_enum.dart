/// Leancloud logger level
/// iOS only have ON or OFF. So when you set OFF, it's OFF. When you set another logger level, it's ON.
enum LeancloudLoggerLevel { OFF, ERROR, WARNING, INFO, DEBUG, VERBOSE, ALL }

/// Leancloud Region
/// iOS not have this property
enum LeancloudCloudRegion { NorthChina, EastChina, NorthAmerica }