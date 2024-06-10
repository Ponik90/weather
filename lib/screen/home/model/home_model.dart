class HomeModel {
  String? name;
  int? id, timezone, cod;
  CoordModel? coord;
  List<WeatherModel?>? weather;
  MainModel? main;
  WindModel? wind;
  CloudsModel? clouds;
  SYSModel? sys;

  HomeModel(
      {this.name,
      this.id,
      this.timezone,
      this.cod,
      this.coord,
      this.weather,
      this.main,
      this.wind,
      this.clouds,
      this.sys});

  factory HomeModel.mapToModel(Map m1) {
    List l1 = m1['weather'];
    return HomeModel(
      id: m1['id'],
      name: m1['name'],
      timezone: m1['timezone'],
      cod: m1['cod'],
      coord: CoordModel.mapToModel(m1['coord']),
      main: MainModel.mapToModel(m1['main']),
      clouds: CloudsModel.maptoModel(m1['clouds']),
      sys: SYSModel.mapToModel(m1['sys']),
      wind: WindModel.mapToModel(m1['wind']),
      weather: l1.map((e) => WeatherModel.mapToModel(e)).toList(),
    );
  }
}

class CoordModel {
  double? lon, lat;

  CoordModel({this.lat, this.lon});

  factory CoordModel.mapToModel(Map m1) {
    return CoordModel(lat: m1['lat'], lon: m1['lon']);
  }
}

class WeatherModel {
  int? id;
  String? main, description, icon;

  WeatherModel({
    this.main,
    this.id,
    this.icon,
    this.description,
  });

  factory WeatherModel.mapToModel(Map m1) {
    return WeatherModel(
      id: m1['id'],
      description: m1['description'],
      icon: m1['icon'],
      main: m1['main'],
    );
  }
}

class MainModel {
  double? temp, feels_like, temp_min, temp_max;

  int? pressure, humidity, sea_level, grnd_level;

  MainModel(
      {this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity,
      this.sea_level,
      this.grnd_level});

  factory MainModel.mapToModel(Map m1) {
    return MainModel(
      feels_like: m1['feels_like'],
      grnd_level: m1['grnd_level'],
      humidity: m1['humidity'],
      pressure: m1['pressure'],
      sea_level: m1['sea_level'],
      temp: m1['temp'],
      temp_max: m1['temp_max'],
      temp_min: m1['temp_min'],
    );
  }
}

class WindModel {
  double? speed, gust;
  int? deg;

  WindModel({
    this.deg,
    this.gust,
    this.speed,
  });

  factory WindModel.mapToModel(Map m1) {
    return WindModel(
      deg: m1['deg'],
      gust: m1['gust'],
      speed: m1['speed'],
    );
  }
}

class CloudsModel {
  int? all;

  CloudsModel({this.all});

  factory CloudsModel.maptoModel(Map m1) {
    return CloudsModel(all: m1['all']);
  }
}

class SYSModel {
  int? sunrise, sunset;
  String? country;

  SYSModel({this.country, this.sunrise, this.sunset});

  factory SYSModel.mapToModel(Map m1) {
    return SYSModel(
        country: m1['country'], sunrise: m1['sunrise'], sunset: m1['sunset']);
  }
}
