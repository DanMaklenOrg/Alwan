final class Config {
  const Config({
    required this.baseUrl,
  });

  const Config.fromEnv()
      : this(
          baseUrl: const String.fromEnvironment('baseUrl'),
        );

  final String baseUrl;
}
