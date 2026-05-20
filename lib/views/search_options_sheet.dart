import 'package:flutter/material.dart';


class SearchOptionsSheet extends StatelessWidget {
  const SearchOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
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
              ListTile(title: Text('Trier par pertinence')),
              ListTile(title: Text('Trier par date')),
              SwitchListTile(title: Text('Inclure archives'), value: true, onChanged: (_) {}),
              // Ajoute ici d'autres options de recherche
            ],
          ),
        );
      },
    );
  }
}