import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ygo_vision/models/request_api.dart';

class Carte {

  int id;
  String name;
  String type;
  String frameType;
  String desc;
  int atk;
  int def;
  int level;
  String race;
  String attribute;
  List<dynamic> card_sets;
  List<dynamic> card_images;
  List<dynamic> card_prices;
  List<dynamic> formats;

  Carte(
    this.id,
    this.name,
    this.type,
    this.frameType,
    this.desc,
    this.atk,
    this.def,
    this.level,
    this.race,
    this.attribute,
    this.card_sets,
    this.card_images,
    this.card_prices,
    this.formats,
  );

  static List<Carte> listeCartes = [];

  static Future<List<Carte>> getCartes() async {
    if (listeCartes.isEmpty) {
      Map<String, dynamic> response = await RequestApi().getAllCards();
      List<dynamic> cartes = response["data"];
      Carte.listeCartes = cartes.map((carte) => Carte.fromJson(carte)).where((carte) => carte.formats.contains("TCG")).toList();
    }
    return Carte.listeCartes;
  }

  factory Carte.fromJson(Map<String, dynamic> json) {
    return Carte(
      int.parse(json["id"].toString()),
      json["name"] ?? '',
      json["type"] ?? '',
      json["frameType"] ?? '',
      json["desc"] ?? '',
      int.tryParse(json["atk"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["def"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["level"]?.toString() ?? '0') ?? 0,
      json["race"] ?? '',
      json["attribute"] ?? '',
      json["card_sets"] ?? [],
      json["card_images"] ?? [],
      json["card_prices"] ?? [],
      json["misc_info"][0]["formats"] ?? [],
    );
  }

  // Parti Firebase ###

  Future<void> add() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCarte = collection.doc(id.toString());

    final snapshotDoc = await docCarte.get();

    int nbExemplaire = 1;
    if(snapshotDoc.exists) {
      final data = snapshotDoc.data();
      nbExemplaire = data?['nb_exemplaire'] + 1;
    }

    await docCarte.set({
      'nb_exemplaire': nbExemplaire,
      'name': name,
    });
  }

  Future<int> getNombreExemplaire() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCarte = collection.doc(id.toString());

    final snapshotDoc = await docCarte.get();

    int nbExemplaire = 0;
    if(snapshotDoc.exists) {
      final data = snapshotDoc.data();
      nbExemplaire = data?['nb_exemplaire'];
    }
    return nbExemplaire;
  }

  Future<void> remove() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCarte = collection.doc(id.toString());

    final snapshotDoc = await docCarte.get();

    int nbExemplaire = 0;
    bool delete = true;
    if(snapshotDoc.exists) {
      final data = snapshotDoc.data();
      nbExemplaire = data?['nb_exemplaire'] - 1;
      if(nbExemplaire > 0) {
        delete = false;
      }
    }
    if(delete) {
      await docCarte.delete();
    } else {
      await docCarte.set({
        'nb_exemplaire': nbExemplaire,
        'name': name,
      });
    }
  }
}
