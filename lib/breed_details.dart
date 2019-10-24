import 'package:cats/api/breed.dart';
import 'package:cats/api/service.dart';
import 'package:flutter/material.dart';

class BreedDetails extends StatefulWidget {
  final Breed breed;

  BreedDetails({Key key, @required this.breed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BreedDetailsState();
  }
}

class BreedDetailsState extends State<BreedDetails> {
  Future<String> _image;
  
  @override
  void initState() {
    super.initState();
    _image = Service.getImage(widget.breed);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.breed.name),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              FutureBuilder<String>(
                  future: _image,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(widget.breed.description),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                          children: [
                            Text('Temperament: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.breed.temperament)
                          ]
                      )
                    ),
                    Row(
                      children: [
                        Text('Origin: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.breed.origin)
                      ]
                    )
                  ],
                )
              )
            ]
        ),
      )
    );
  }
}