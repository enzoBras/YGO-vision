import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_vision/models/carte.dart';
import 'package:ygo_vision/views/tools.dart';

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
                title: const Text('Cartes'),
              ),
              body: ListView.builder(
                itemCount: cartes.length,
                itemBuilder: (BuildContext context, int index) {
                  final carte = cartes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 80,
                        child: CachedNetworkImage(
                          imageUrl: carte.card_images[0]['image_url'],
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      title: Text(carte.name),
                      subtitle: Text(carte.type),
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
