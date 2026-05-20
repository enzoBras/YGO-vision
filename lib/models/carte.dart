import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ygo_vision/models/request_api.dart';
import 'package:ygo_vision/models/search_filters.dart';
import 'package:collection/collection.dart';

class Carte {

  int id;
  String name;
  String type;
  List<String> subTypes;
  String frameType;
  String desc;
  int atk;
  int def;
  int level;
  int link;
  int scale;
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
    this.subTypes,
    this.frameType,
    this.desc,
    this.atk,
    this.def,
    this.level,
    this.link,
    this.scale,
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
      try {
        Map<String, dynamic> response = await RequestApi().getAllCards();
        List<dynamic> cartes = response["data"];
        Carte.listeCartes = cartes.map((carte) => Carte.fromJson(carte))
            .where((carte) => carte.formats.contains("TCG")).toList();
        getCollectionCarte();
      } catch (e) {
        print("Error lors du chargement de l'API");
        return [];
      }
    }
    return Carte.listeCartes;
  }

  factory Carte.fromJson(Map<String, dynamic> json) {
    String type = json["type"] ?? '';
    List<String> subtypes = [];

    for (final keyword in ["Toon", "Spirit", "Union", "Gemini", "Tuner", "Flip", "Pendulum"]) {
      if (type.contains(keyword)) {
        subtypes.add(keyword);
      }
    }

    return Carte(
      int.parse(json["id"].toString()),
      json["name"] ?? '',
      type,
      subtypes,
      json["frameType"] ?? '',
      json["desc"] ?? '',
      int.tryParse(json["atk"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["def"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["level"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["linkval"]?.toString() ?? '0') ?? 0,
      int.tryParse(json["scale"]?.toString() ?? '0') ?? 0,
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

  static List<Carte> applyFilters(List<Carte> cartes, SearchFilters filters) {
    return cartes.where((carte) {
      if (filters.attributs.isNotEmpty && !filters.attributs.contains(carte.attribute)) {
        return false;
      }
      if (filters.types.isNotEmpty && !filters.types.contains(carte.race)) {
        return false;
      }
      if (filters.autres.isNotEmpty) {
        bool boolean = filters.autres.any((filter) => carte.type.contains(filter) || carte.subTypes.contains(filter));
        if (!boolean) {
          return false;
        }
      }
      if (filters.niveaux.isNotEmpty && !filters.niveaux.contains(carte.level)) {
        return false;
      }
      if (filters.pendules.isNotEmpty && !filters.pendules.contains(carte.scale)) {
        return false;
      }
      if (filters.liens.isNotEmpty && !filters.liens.contains(carte.link)) {
          return false;
      }

      if (filters.atkMin != null && carte.atk < filters.atkMin!) return false;
      if (filters.atkMax != null && carte.atk > filters.atkMax!) return false;

      if (filters.defMin != null && carte.def < filters.defMin!) return false;
      if (filters.defMax != null && carte.def > filters.defMax!) return false;

      if (filters.magies.isNotEmpty) {
        bool match = carte.type.contains("Spell") && filters.magies.contains(carte.race);
        if (!match) return false;
      }
      if (filters.pieges.isNotEmpty) {
        bool match = carte.type.contains("Trap") && filters.pieges.contains(carte.race);
        if (!match) return false;
      }

      return true;
    }).toList();
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

  @override
  String toString() {
    return 'Carte('
      'id:$id,'
      'name:$name,'
      'type:$type,'
      'subTypes:$subTypes,'
      'frameType:$frameType,'
      'desc:$desc,'
      'atk:$atk,'
      'def:$def,'
      'level:$level,'
      'link:$link,'
      'scale:$scale,'
      'race:$race,'
      'attribute:$attribute,'
      'card_sets:$card_sets,'
      'card_images:$card_images,'
      'card_prices:$card_prices,'
      'formats:$formats,'
      'nbExemplaire:$nbExemplaire,'
      ')';
  }


}
