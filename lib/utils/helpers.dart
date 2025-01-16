class Helpers {
  static Map<String, String> parseArgument(List<String> argument) {
    final Map<String, String> argMap = <String, String>{};
    for (final arg in argument) {
      final List parts = arg.split('=');
      if (parts.length == 2) {
        argMap[parts[0].replaceAll('--', '')] = parts[1];
      }
    }
    return argMap;
  }
}
