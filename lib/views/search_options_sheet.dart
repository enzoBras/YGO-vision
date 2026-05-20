import 'package:flutter/material.dart';
import 'package:ygo_vision/models/search_filters.dart';
import 'package:ygo_vision/views/tools.dart';

class SearchOptionsSheet extends StatefulWidget {
  const SearchOptionsSheet({super.key});

  @override
  State<SearchOptionsSheet> createState() => _SearchOptionsSheetState();
}

class _SearchOptionsSheetState extends State<SearchOptionsSheet> {
  late SearchFilters searchFilters;
  Set<String> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    searchFilters = SearchFilters();
  }

  Widget button(String titre, String option, String category) {
    final isSelected = selectedOptions.contains(option);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () => {
        setState(() {
          if(isSelected) {
            selectedOptions.remove(option);
            searchFilters.removeFromCategory(option, category);
          } else {
            selectedOptions.add(option);
            searchFilters.addToCategory(option, category);
          }
        })
      },
      child: Text(titre),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return DefaultTabController(
          length: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(text: 'Monstres',),
                    Tab(text: 'Magies-Pièges',),
                  ]
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Monstres
                      ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(16),
                        children: [
                          Text("Attributs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                              spacing: 8,
                              children: [
                                button("TÉNÈBRES", "DARK",'attribut'),
                                button("LUMIÈRE", "LIGHT",'attribut'),
                                button("TERRE", "EARTH",'attribut'),
                                button("EAU", "WATER",'attribut'),
                                button("FEU", "FIRE",'attribut'),
                                button("VENT", "WIND",'attribut'),
                                button("DIVIN", "DIVINE",'attribut'),
                              ]
                          ),
                          SizedBox(height: 16,),
                          Text("Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("Aqua", "Aqua", 'type'),
                              button("Bête", "Beast", 'type'),
                              button("Bête Ailée", "Winged Beast", 'type'),
                              button("Bête-Divine", "Divine-Beast", 'type'),
                              button("Bête-Guerrier", "Beast-Warrior", 'type'),
                              button("Cyberse", "Cyberse", 'type'),
                              button("Démon", "Fiend", 'type'),
                              button("Dinosaure", "Dinosaur", 'type'),
                              button("Dragon", "Dragon", 'type'),
                              button("Elfe", "Fairy", 'type'),
                              button("Guerrier", "Warrior", 'type'),
                              button("Illusion", "Illusion", 'type'),
                              button("Insecte", "Insect", 'type'),
                              button("Machine", "Machine", 'type'),
                              button("Magicien", "Spellcaster", 'type'),
                              button("Plante", "Plant", 'type'),
                              button("Poisson", "Fish", 'type'),
                              button("Psychique", "Psychic", 'type'),
                              button("Pyro", "Pyro", 'type'),
                              button("Reptile", "Reptile", 'type'),
                              button("Rocher", "Rock", 'type'),
                              button("Serpent de Mer", "Sea Serpent", 'type'),
                              button("Tonnerre", "Thunder", 'type'),
                              button("Wyrm", "Wyrm", 'type'),
                              button("Zombie", "Zombie", 'type'),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("Autre", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("Normaux", "Normal",'autre'),
                              button("Effet", "Effect",'autre'),
                              button("Rituel", "Ritual",'autre'),
                              button("Fusion", "Fusion",'autre'),
                              button("Synchro", "Synchro",'autre'),
                              button("Xyz", "Xyz",'autre'),
                              button("Toon", "Toon",'autre'), //
                              button("Spirit", "Spirit",'autre'), //
                              button("Union", "Union",'autre'), //
                              button("Gémeau", "Gemini",'autre'), //
                              button("Syntoniseur", "Tuner",'autre'), //
                              button("Flip", "Flip",'autre'), //
                              button("Pendule", "Pendulum",'autre'), //
                              button("Lien", "Link",'autre'),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("Niveaux/rang", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("0", "niveau_0",'niveau'),
                              button("1", "niveau_1",'niveau'),
                              button("2", "niveau_2",'niveau'),
                              button("3", "niveau_3",'niveau'),
                              button("4", "niveau_4",'niveau'),
                              button("5", "niveau_5",'niveau'),
                              button("6", "niveau_6",'niveau'),
                              button("7", "niveau_7",'niveau'),
                              button("8", "niveau_8",'niveau'),
                              button("9", "niveau_9",'niveau'),
                              button("10", "niveau_10",'niveau'),
                              button("11", "niveau_11",'niveau'),
                              button("12", "niveau_12",'niveau'),
                              button("13", "niveau_13",'niveau'),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("Échelle Pendule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("0", "pendule_0",'pendule'),
                              button("1", "pendule_1",'pendule'),
                              button("2", "pendule_2",'pendule'),
                              button("3", "pendule_3",'pendule'),
                              button("4", "pendule_4",'pendule'),
                              button("5", "pendule_5",'pendule'),
                              button("6", "pendule_6",'pendule'),
                              button("7", "pendule_7",'pendule'),
                              button("8", "pendule_8",'pendule'),
                              button("9", "pendule_9",'pendule'),
                              button("10", "pendule_10",'pendule'),
                              button("11", "pendule_11",'pendule'),
                              button("12", "pendule_12",'pendule'),
                              button("13", "pendule_13",'pendule'),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("Lien", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("1", "lien_1",'lien'),
                              button("2", "lien_2",'lien'),
                              button("3", "lien_3",'lien'),
                              button("4", "lien_4",'lien'),
                              button("5", "lien_5",'lien'),
                              button("6", "lien_6",'lien'),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("ATK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Min'
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    int? atk = int.tryParse(value);
                                    if (atk != null) {
                                      searchFilters.atkMin = atk;
                                    } else {
                                      callToast("veuillez rentrer un nombre dans l'ATK Min");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Max'
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    int? atk = int.tryParse(value);
                                    if (atk != null) {
                                      searchFilters.atkMax = atk;
                                    } else {
                                      callToast("veuillez rentrer un nombre dans l'ATK Max");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Text("DEF", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Min'
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    int? def = int.tryParse(value);
                                    if (def != null) {
                                      searchFilters.defMin = def;
                                    } else {
                                      callToast("veuillez rentrer un nombre dans la DEF Min");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Max'
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    int? def = int.tryParse(value);
                                    if (def != null) {
                                      searchFilters.defMax = def;
                                    } else {
                                      callToast("veuillez rentrer un nombre dans la DEF Max");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // On veut afficher que les monstres
                                if (searchFilters.autres.isEmpty) {
                                  searchFilters.autres.addAll(["Monster"]);
                                }
                                Navigator.pop(context, searchFilters);
                              },
                              icon: Icon(Icons.check),
                              label: Text("Appliquer les filtres"),
                            )
                          )
                        ],
                      ),
                      // Magie et piège
                      ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(16),
                        children: [
                          Text("Magie", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("Normal", "magie_Normal",'magie'),
                              button("Continu", "magie_Continuous",'magie'),
                              button("Jeu-Rapide", "magie_Quick-Play",'magie'),
                              button("Équipement", "magie_Equip",'magie'),
                              button("Terrain", "magie_Field",'magie'),
                              button("Rituel", "magie_Ritual",'magie'),
                            ]
                          ),
                          SizedBox(height: 16,),
                          Text("Piège", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: [
                              button("Normal", "piege_Normal",'piege'),
                              button("Continu", "piege_Continuous",'piege'),
                              button("Contre", "piege_Counter",'piege'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context, searchFilters);
                              },
                              icon: Icon(Icons.check),
                              label: Text("Appliquer les filtres"),
                            )
                          )
                        ],
                      )
                    ]
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}