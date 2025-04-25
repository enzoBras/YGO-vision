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
  final SearchController searchController = SearchController();
  List<Carte> allCartes = [];
  List<Carte> cartes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
    _loadCartes();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
  }

  void _loadCartes() async {
    allCartes = await Carte.getCartes();
    setState(() {
      cartes = allCartes;
      isLoading = false;
    });
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        cartes = allCartes;
      });
    } else {
      setState(() {
        cartes = allCartes.where((Carte carte) =>
            carte.name.toLowerCase().contains(query.toLowerCase())
        ).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: searchController,
          leading: Icon(Icons.search),
          hintText: 'Rechercher',
          elevation: WidgetStateProperty.all(0),
        ),
      ),
      body: isLoading
        ? widgetCercleProgression()
        : cartes.isEmpty
          ? Center(child: Text("Aucun carte trouvée"),)
          : GridView.builder(
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
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                  ),
                ),
              );
            }),
    );
  }
}
