import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_vision/models/carte.dart';
import 'package:ygo_vision/views/tools.dart';

class DetailCard extends StatefulWidget {
  final Carte carte;
  const DetailCard(this.carte, {super.key});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  late final ScrollController _descScrollController;
  late final ScrollController _setsScrollController;
  final ValueNotifier<int> _notifyNbExemplaire = ValueNotifier<int>(0);

  @override
  void initState() {
    _descScrollController = ScrollController();
    _setsScrollController = ScrollController();
    _notifyNbExemplaire.value = widget.carte.nbExemplaire;
    super.initState();
  }

  @override
  void dispose() {
    _descScrollController.dispose();
    _setsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails carte"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.carte.card_images[0]['image_url_small'],
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                  width: 200,
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.carte.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Card Name"
                        ),
                        softWrap: true,
                      ),
                      Text(
                        widget.carte.type,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Card Name"
                        ),
                        softWrap: true,
                      ),
                      Text(
                        widget.carte.attribute != "" ? "${widget.carte.attribute} / ${widget.carte.race}" : widget.carte.race,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Card Type"
                        ),
                        softWrap: true,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _notifyNbExemplaire,
                        builder: (BuildContext context, value, Widget? child) {
                          return Text(
                            "Nombre d'exemplaire dans la collection : $value",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Card Name"
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await widget.carte.add();
                              callToast("Carte ajoutée à la collection");
                              _notifyNbExemplaire.value = widget.carte.nbExemplaire;
                            },
                            icon: Icon(Icons.add_box)
                          ),
                          IconButton(
                            onPressed: () async {
                              await widget.carte.remove();
                              callToast("Carte retirée de la collection");
                              _notifyNbExemplaire.value = widget.carte.nbExemplaire;
                            },
                            icon: Icon(Icons.indeterminate_check_box)
                          )
                        ],
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: RawScrollbar(
                thumbVisibility: true,
                controller: _descScrollController,
                child: SingleChildScrollView(
                  controller: _descScrollController,
                  child: Text(
                    widget.carte.desc,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Card Effect"
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: RawScrollbar(
                controller: _setsScrollController,
                child: ListView.builder(
                  controller: _setsScrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.carte.card_sets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final set = widget.carte.card_sets[index];
                    return ListTile(
                      title: Text(set["set_name"]),
                      subtitle: Text(set["set_code"]),
                      trailing: Text(set["set_rarity"]),
                    );
                  }
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
