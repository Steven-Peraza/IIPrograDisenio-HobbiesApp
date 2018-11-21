import 'package:flutter/material.dart';
import '../../models/publication_model.dart';
import 'package:http/http.dart' show post,get;
import '../../CONSTANTS.dart';

class PublicationItem extends StatefulWidget {
  PublicationModel publication;
  PublicationItem(this.publication);
  @override
    State<PublicationItem> createState() {
      // TODO: implement createState
      return PublicationItemState();
    }
}

class PublicationItemState extends State<PublicationItem> {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Card(
        color: Colors.amber[200],
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
       ListTile(
        leading: Icon(Icons.dashboard),
        title: Text(widget.publication.hobby),
        subtitle: Text(widget.publication.text),
        trailing: Text(widget.publication.username),
      ),
      Image.network(widget.publication.mediaLink),
      ButtonTheme.bar( // make buttons use the appropriate styles for cards
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child:  Icon(Icons.favorite),
              onPressed: () { /* ... */ },
            ),
            FlatButton(
              child: Icon(Icons.comment),
              onPressed: () { /* ... */ },
            ),
          ],
        ),
      ),
    ],
  ),
);
    }
}