class exampleDb {
  static final exampleDb _instance = exampleDb._internal();

  factory exampleDb() => _instance;

  exampleDb._internal();
  Map<String, String> userDatabase = {
    '12345678909': 'abcdei',
    '12345678913': 'abcdel',
  };

  Map<double, String> accountNum = {
    12345678909: "likitha",
    12345678913: "ruchitha",
  };
  Map<String, Map<String, String>> userData = {
    'likitha': {'password': 'Amma@123', 'nickname': 'liki'},
    'ruchitha': {'password': 'abc@1234', 'nickname': 'ruchi'},
  };
  Map<String, String> getReverseUserDatabase() {
    return {for (var entry in userDatabase.entries) entry.value: entry.key};
  }
}
