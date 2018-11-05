import 'package:flutter/material.dart';
import '../../models/publication_model.dart';
import './publication_item.dart';

class PublicationList extends StatelessWidget {
final List<PublicationModel> publications;

PublicationList(this.publications);

Widget build(context) {
return ListView.builder(
  itemCount: publications.length,
  itemBuilder: (context, int index) {
     return PublicationItem(publications[index]);
  }
);
}
}