String? extractAndProcessToken(String cookies) {
  final tokenPattern = RegExp(r'token=([^;]*)');
  final match = tokenPattern.firstMatch(cookies);

  if (match != null && match.groupCount >= 1) {
    final token = match.group(1);
    if (token != null) {
      return token;
    }
  } else {
    print('Token not found in cookies');
  }
  return null;
}
