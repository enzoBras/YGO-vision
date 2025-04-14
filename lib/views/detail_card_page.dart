import 'package:flutter/material.dart';
import '../models/carte.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: Image.network(widget.carte.card_images[0]['image_url_cropped'],),
          title: Text(widget.carte.name),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Text(widget.carte.desc),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
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
        ],
      ),
    );
  }
}
