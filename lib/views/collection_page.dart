import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_vision/models/carte.dart';
import 'package:ygo_vision/views/detail_card_page.dart';
import 'package:ygo_vision/views/tools.dart';
import 'package:badges/badges.dart' as badges;

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final SearchController searchController = SearchController();
  List<Carte> allCartesCollection = [];
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
    allCartesCollection = await Carte.getCollectionCarte();
    setState(() {
      cartes = allCartesCollection;
      isLoading = false;
    });
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        cartes = allCartesCollection;
      });
    } else {
      setState(() {
        cartes = allCartesCollection.where((Carte carte) =>
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
                onTap: () async {
                  await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return DetailCard(carte);
                    })
                  );
                  setState(() {
                    // On rafraîchit la page
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  child: badges.Badge(
                    stackFit: StackFit.passthrough,
                    badgeAnimation: badges.BadgeAnimation.scale(),
                    position: badges.BadgePosition.bottomEnd(bottom: -12, end:0),
                    badgeContent: Text(
                      '${carte.nbExemplaire}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.blue,
                      padding: EdgeInsets.all(5),
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                      elevation: 0,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: carte.card_images[0]['image_url_small'],
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              );
            }),
    );
  }
}