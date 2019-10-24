import 'package:cats/breed_details.dart';
import 'package:flutter/material.dart';

import 'api/breed.dart';
import 'api/service.dart';

class BreedsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BreedsListState();
}

class BreedsListState extends State<BreedsList> {
  final Future<List<Breed>> _breeds = Service.getBreeds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
      ),
      body: FutureBuilder<List<Breed>>(
        future: _breeds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Iterable<ListTile> tiles = snapshot.data.map((breed) => ListTile(
              title: Text(breed.name),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BreedDetails(breed: breed)
                ));
              }
            ));
            final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();
            return ListView(
                children: divided,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
