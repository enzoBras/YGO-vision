import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ygo_vision/models/request_api.dart';
import 'package:collection/collection.dart';

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
  int nbExemplaire = 0;

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

  static Future<List<Carte>> getAPICartes() async {
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

  static Carte? getCarteById(int id) {
    return listeCartes.firstWhereOrNull((carte) => carte.id == id);
  }

  // Parti Firebase ###

  Future<void> add() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCarte = collection.doc(id.toString());

    final snapshotDoc = await docCarte.get();

    int nbExemplaireFirebase = 1;
    if(snapshotDoc.exists) {
      final data = snapshotDoc.data();
      nbExemplaireFirebase = data?['nb_exemplaire'] + 1;
    }

    await docCarte.set({
      'nb_exemplaire': nbExemplaireFirebase,
      'name': name,
    });

    nbExemplaire ++;
  }

  Future<void> remove() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCarte = collection.doc(id.toString());

    final snapshotDoc = await docCarte.get();

    int nbExemplaireFirebase = 0;
    bool delete = true;
    if(snapshotDoc.exists) {
      final data = snapshotDoc.data();
      nbExemplaireFirebase = data?['nb_exemplaire'] - 1;
      if(nbExemplaireFirebase > 0) {
        delete = false;
      }
    }
    if(delete) {
      await docCarte.delete();
    } else {
      await docCarte.set({
        'nb_exemplaire': nbExemplaireFirebase,
        'name': name,
      });
    }

    if(nbExemplaire >=1) {
      nbExemplaire --;
    }
  }

  static Future<List<Carte>> getCollectionCarte() async {
    final collection = FirebaseFirestore.instance.collection('Collection');
    final docCartes = await collection.get();

    if (listeCartes.isEmpty) {
      listeCartes = await getAPICartes();
    }

    return docCartes.docs.map((collection) {
      int id = int.parse(collection.id);
      Carte? carte = Carte.getCarteById(id);
      carte?.nbExemplaire = collection.data()['nb_exemplaire'];
      return carte;
    }).whereType<Carte>().toList();
  }
}
