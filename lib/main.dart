import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gempa_cuaca_app/gempa_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gempa_cuaca_app/gempa_5.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Info Gempa",
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // ignore: avoid_init_to_null
  GempaTerkini? gempaTerkini = null;

  String tanggal = "No Data";
  String jam = "No Data";
  String koordinat = "No Data";
  String magnitude = "No Data";
  String kedalaman = "No Data";
  String wilayah = "No Data";
  String dirasakan = "No Data";
  String potensi = "No Data";
  String shakemap = "20210605215200.mmi.jpg";
  String lastUp = "No Data";

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tanggal = pref.getString('tanggal') ?? "No Data";
    jam = pref.getString('jam') ?? "No Data";
    koordinat = pref.getString('koordinat') ?? "No Data";
    magnitude = pref.getString('magnitude') ?? "No Data";
    kedalaman = pref.getString('kedalaman') ?? "No Data";
    wilayah = pref.getString('wilayah') ?? "No Data";
    dirasakan = pref.getString('dirasakan') ?? "No Data";
    potensi = pref.getString('potensi') ?? "No Data";
    shakemap = pref.getString('shakemap') ?? "20210605215200.mmi.jpg";
    lastUp = pref.getString('lastup') ?? "No Data";
  }

  Future<void> setPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('tanggal', gempaTerkini!.tanggal);
    pref.setString('jam', gempaTerkini!.jam);
    pref.setString('koordinat', gempaTerkini!.koordinat);
    pref.setString('magnitude', gempaTerkini!.magnitude);
    pref.setString('kedalaman', gempaTerkini!.kedalaman);
    pref.setString('wilayah', gempaTerkini!.wilayah);
    pref.setString('dirasakan', gempaTerkini!.dirasakan);
    pref.setString('potensi', gempaTerkini!.potensi);
    pref.setString('shakemap', gempaTerkini!.shakemap);
    pref.setString('lastup', lastUp);
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  void setLastUpdate() {
    String tanggal = DateFormat('d MMM yyyy hh:mm:ss').format(DateTime.now());
    lastUp = tanggal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: Color(0xFFD5F6F1),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 90),
              ListTile(
                title: Text(
                  "Daftar 15 Gempabumi M 5.0+",
                ),
                hoverColor: Color(0xFFFFFFFF),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageTwo()));
                },
              ),
              ListTile(
                title: Text(
                  "Daftar 15 Gempabumi Dirasakan",
                ),
                hoverColor: Color(0xFFFFFFFF),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Info Gempa"),
        backgroundColor: Color(0xFF70D0A6),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gempa Terkini yang dirasakan",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Last Update: " + lastUp,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      GempaTerkini.connectToAPI().then((value) {
                        gempaTerkini = value;
                        setLastUpdate();
                        setPref();
                        setState(() {});
                      });
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Jam: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Koordinat: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Magnitude: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Kedalaman: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(gempaTerkini?.tanggal ?? tanggal),
                      Text(gempaTerkini?.jam ?? jam),
                      Text(gempaTerkini?.koordinat ?? koordinat),
                      Text(gempaTerkini?.magnitude ?? magnitude),
                      Text(gempaTerkini?.kedalaman ?? kedalaman),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Divider(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xFFCADEE7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Divider(),
                    Text(
                      gempaTerkini?.wilayah ?? wilayah,
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    Text(
                      gempaTerkini?.dirasakan ?? dirasakan,
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    Text(
                      gempaTerkini?.potensi ?? potensi,
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: (gempaTerkini != null)
                      ? Image.network(
                          'https://data.bmkg.go.id/DataMKG/TEWS/${gempaTerkini!.shakemap}')
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
