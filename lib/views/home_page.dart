import 'package:flutter/material.dart';
import 'package:ygo_vision/views/scan_page.dart';
import 'package:ygo_vision/views/collection_page.dart';
import 'package:ygo_vision/views/deck_page.dart';
import 'package:ygo_vision/views/cards_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      const CardsPage(),
      const CollectionPage(),
      const DeckPage(),
      const ScanPage()
    ];

    const List<BottomNavigationBarItem> items =[
      BottomNavigationBarItem(icon: Image(image: AssetImage("assets/img/cards.png"), width: 40, height: 40), label: 'Cards'),
      BottomNavigationBarItem(icon: Image(image: AssetImage("assets/img/collection.png"), width: 40, height: 40), label: 'Collection'),
      BottomNavigationBarItem(icon: Image(image: AssetImage("assets/img/deck.png"), width: 40, height: 40), label: 'Deck'),
      BottomNavigationBarItem(icon: Image(image: AssetImage("assets/img/scan.png"), width: 40, height: 40), label: 'Scan',),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[BoxShadow(
              color: Colors.blueGrey,
            ),]
          ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal[900],
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.teal[300],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: items,
        ),
      )
    );
  }
}
