class SearchFilters {
  // filtres pour monstres
  List<String> attributs = [];
  List<String> types = [];
  List<String> autres = [];
  List<int> niveaux = [];
  List<int> pendules = [];
  List<int> liens = [];
  int? atkMin;
  int? atkMax;
  int? defMin;
  int? defMax;

  // filtres pour magies/pièges
  List<String> magies = [];
  List<String> pieges = [];


  SearchFilters();

  void addToCategory(String option, String category) {
    switch (category) {
      case 'attribut':
        attributs.add(option);
        break;
      case 'type':
        types.add(option);
        break;
      case 'autre':
        autres.add(option);
        break;
      case 'niveau':
        int niveau = int.parse(option.split("_").last);
        niveaux.add(niveau);
        break;
      case 'pendule':
        int penduleVal = int.parse(option.split("_").last);
        pendules.add(penduleVal);
        break;
      case 'lien':
        int linkVal = int.parse(option.split("_").last);
        liens.add(linkVal);
        break;
      case 'magie':
        magies.add(option.split("_").last);
        break;
      case 'piege':
        pieges.add(option.split("_").last);
        break;
    }
  }

  void removeFromCategory(String option, String category) {
    switch (category) {
      case 'attribut':
        attributs.remove(option);
        break;
      case 'type':
        types.remove(option);
        break;
      case 'autre':
        autres.remove(option);
        break;
      case 'niveau':
        int niveau = int.parse(option.split("_").last);
        niveaux.remove(niveau);
        break;
      case 'pendule':
        int scaleVal = int.parse(option.split("_").last);
        pendules.remove(scaleVal);
        break;
      case 'lien':
        int linkVal = int.parse(option.split("_").last);
        liens.remove(linkVal);
        break;
      case 'magie':
        magies.remove(option.split("_").last);
        break;
      case 'piege':
        pieges.remove(option.split("_").last);
        break;
    }
  }

  @override
  String toString() {
    return 'SearchFilters('
      'attributs: $attributs, types: $types, autres: $autres, '
      'niveaux: $niveaux, pendules: $pendules, liens: $liens, '
      'atkMin: $atkMin, atkMax: $atkMax, defMin: $defMin, defMax: $defMax, '
      'magies: $magies, pieges: $pieges)';
  }
}