import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/model/place.dart';
import 'package:places/provider/user_places.dart';
import 'package:places/widgets/image_input.dart';
import 'package:places/widgets/location_input.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty ||
        _pickedImage == null ||
        _selectedLocation == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _pickedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                cursorColor: Colors.white,
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  _pickedImage = image;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              LocationInput(
                onSelectLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _savePlace,
                style: const ButtonStyle(alignment: Alignment.center),
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
