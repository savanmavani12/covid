

import 'package:covid/globals/global.dart';

class Covid {
  final int todayRecovered;
  final int todayCases;
  final int active;
  final int todayDeaths;
  late String flag;

  Covid.all(
      {required this.active,
      required this.todayCases,
      required this.todayRecovered,
      required this.todayDeaths,
      required this.flag});

  Covid.countries({
    required this.active,
    required this.todayCases,
    required this.todayRecovered,
    required this.todayDeaths,
    required this.flag,
  });

  factory Covid.fromMap({required Map data}) {
    if (Global.api == 1) {
      return Covid.all(
          active: data["active"],
          todayCases: data["todayCases"],
          todayRecovered: data["todayRecovered"],
          todayDeaths: data["todayDeaths"],
          flag:
              "https://w7.pngwing.com/pngs/269/407/png-transparent-earth-globe-world-logo-earth-globe-logo-world.png");
    } else {
      return Covid.countries(
        active: data["active"],
        todayCases: data["todayCases"],
        todayRecovered: data["todayRecovered"],
        todayDeaths: data["todayDeaths"],
        flag: data["countryInfo"]["flag"],
      );
    }
  }
}


class Countries
{
  final String name;
  
  Countries({required this.name});
  factory Countries.fromMap({required Map data})
  {
    return Countries(name: data["name"]);
  }
}