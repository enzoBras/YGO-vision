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

  @override
  void initState() {
    _descScrollController = ScrollController();
    _setsScrollController = ScrollController();
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
                Image.network(
                  widget.carte.card_images[0]['image_url_small'],
                  scale: 1.8,
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
                        "${widget.carte.frameType} / ${widget.carte.race}",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Card Type"
                        ),
                        softWrap: true,
                      ),
                      /*FutureBuilder(
                        future: widget.carte.getNombreExemplaire(),
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          Widget widget = const SizedBox();
                          if (snapshot.hasData) {
                            widget = Text("Nombre en stock : ${snapshot.data}");
                          }
                          if (snapshot.hasError) {
                            widget = widgetError();
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            widget = widgetCercleProgression();
                          }
                          return widget;
                        }
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.carte.add();
                              callToast("Carte ajouté à la collection");
                            },
                            icon: Icon(Icons.add_box)
                          ),
                          IconButton(
                            onPressed: () {
                              widget.carte.remove();
                              callToast("Carte retiré de la collection");
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
                controller: _descScrollController,
                child: SingleChildScrollView(
                  controller: _descScrollController,
                  child: Text(
                    widget.carte.desc,
                    textAlign: TextAlign.justify,
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
