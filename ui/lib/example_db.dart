Map<String, String> userDatabase = {
  '1234567890': 'abcdef',
}; // Simulated backend storage
Map<String, String> getReverseUserDatabase() {
  return {for (var entry in userDatabase.entries) entry.value: entry.key};
}
