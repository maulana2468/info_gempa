import 'dart:convert';
import 'package:http/http.dart' as http;

class GempaTerkini {
  late String tanggal;
  late String jam;
  late String koordinat;
  late String magnitude;
  late String kedalaman;
  late String wilayah;
  late String potensi;
  late String dirasakan;
  late String shakemap;

  GempaTerkini({
    required this.tanggal,
    required this.jam,
    required this.koordinat,
    required this.magnitude,
    required this.kedalaman,
    required this.wilayah,
    required this.dirasakan,
    required this.potensi,
    required this.shakemap,
  });

  factory GempaTerkini.createData(Map<String, dynamic> object) {
    return GempaTerkini(
      tanggal: object['Tanggal'],
      jam: object['Jam'],
      koordinat: object['Coordinates'],
      magnitude: object['Magnitude'],
      kedalaman: object['Kedalaman'],
      wilayah: object['Wilayah'],
      dirasakan: object['Dirasakan'],
      potensi: object['Potensi'],
      shakemap: object['Shakemap'],
    );
  }

  static Future<GempaTerkini> connectToAPI() async {
    String apiURL = 'https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json';

    var result = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(result.body);
    var eqData = (jsonObject as Map<String, dynamic>)['Infogempa']['gempa'];

    return GempaTerkini.createData(eqData);
  }
}
