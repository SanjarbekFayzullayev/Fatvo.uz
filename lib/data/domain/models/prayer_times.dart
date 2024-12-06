class PrayerTimes {
  String? date;
  String? active;
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  PrayerTimes(
      {this.date,
        this.active,
        this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.maghrib,
        this.isha});

  PrayerTimes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    active = json['active'];
    fajr = json['fajr'];
    sunrise = json['sunrise'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    maghrib = json['maghrib'];
    isha = json['isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['date'] = this.date;
    data['active'] = this.active;
    data['fajr'] = this.fajr;
    data['sunrise'] = this.sunrise;
    data['dhuhr'] = this.dhuhr;
    data['asr'] = this.asr;
    data['maghrib'] = this.maghrib;
    data['isha'] = this.isha;
    return data;
  }
}
