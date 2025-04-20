import 'package:flutter/material.dart';
import 'package:ygo_vision/models/carte.dart';

class DetailCard extends StatefulWidget {
  final Carte carte;
  const DetailCard(this.carte, {super.key});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
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
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              widget.carte.desc,
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
            child: ListView.builder(
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
            )
          ),
        ],
      ),
    );
  }
}
