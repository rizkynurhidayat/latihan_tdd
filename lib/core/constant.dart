class Urls {
  static const String baseUrl = 'http://numbersapi.com';
  // static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String concreateNumberTriviaByNumber(int number) =>
      '$baseUrl/$number?json';
  static String randomNumberTriviaByNumber() => '$baseUrl/random/trivia?json';
  // static String weatherIcon(String iconCode) =>
  //     'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
