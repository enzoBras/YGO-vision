import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_vision/models/carte.dart';
import 'package:ygo_vision/views/tools.dart';

import 'detail_card_page.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Carte.getCartes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return widgetError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widgetCercleProgression();
          }
          if(snapshot.hasData) {
            final cartes = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Recherche bar'),
              ),
              body: GridView.builder(
                itemCount: cartes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final carte = cartes[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return DetailCard(carte);
                          }));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      child: CachedNetworkImage(
                        imageUrl: carte.card_images[0]['image_url_small'],
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  );
                }),
            );
          }
          return const SizedBox();
        }
    );
  }
}
