class WeatherModel {
  final String name;
  final String region;
  final String country;
  final double tempC;
  final String lastUpdated;
  final String text;
  final String icon;

  WeatherModel({
    required this.name,
    required this.region,
    required this.country,
    required this.tempC,
    required this.lastUpdated,
    required this.text,
    required this.icon,
  });

}
WeatherModel setWeather(response) {
  return WeatherModel(
    name: response['location']['name'],
    region: response['location']['region'],
    country: response['location']['country'],
    tempC: response['current']['temp_c'],
    lastUpdated: response['current']['last_updated'],
    text: response['current']['condition']['text'],
    icon: response['current']['condition']['icon'].replaceAll('//', 'https://'),
  );
}