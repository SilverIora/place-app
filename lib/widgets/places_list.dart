import 'package:flutter/material.dart';

import '../model/place.dart';
import '../screens/place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isNotEmpty) {
      return ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) => Dismissible(
          onDismissed: (direction) => (),
          key: ValueKey(places[index]),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(places[index].image),
              radius: 26,
            ),
            title: Text(
              places[index].name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              places[index].location.address,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PlaceDetailScreen(place: places[index])));
            },
          ),
        ),
      );
    }
    return Center(
        child: Text(
      'Add Item',
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    ));
  }
}
