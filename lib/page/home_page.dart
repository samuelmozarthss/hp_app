import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:potterhead_app/characterModel.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CharacterModel> characters = [];

  Future fetchCharacters() async {
    var response = await http.get(
      Uri.https('hp-api.onrender.com', 'api/characters'),
    );
    var jsonData = jsonDecode(response.body);

    for (var eachCharacter in jsonData) {
      final Map<String, dynamic> wandData = eachCharacter['wand'];
      Wand wand = Wand.fromJson(wandData);

      final character = CharacterModel(
        id: eachCharacter['id'],
        name: eachCharacter['name'],
        alternateNames: eachCharacter['alternate_names'].cast<String>(),
        species: eachCharacter['species'],
        gender: eachCharacter['gender'],
        house: eachCharacter['house'],
        dateOfBirth: eachCharacter['dateOfBirth'] ?? "",
        yearOfBirth: eachCharacter['yearOfBirth'] ?? 0,
        wizard: eachCharacter['wizard'],
        ancestry: eachCharacter['ancestry'],
        eyeColour: eachCharacter['eyeColour'],
        hairColour: eachCharacter['hairColour'],
        wand: wand,
        patronus: eachCharacter['patronus'],
        hogwartsStudent: eachCharacter['hogwartsStudent'],
        hogwartsStaff: eachCharacter['hogwartsStaff'],
        actor: eachCharacter['actor'],
        alternateActors: eachCharacter['alternate_actors'],
        alive: eachCharacter['alive'],
        image: eachCharacter['image'] ?? "",
      );
      characters.add(character);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCharacters();
    return Scaffold(
      body: FutureBuilder(
        future: fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  elevation: 15,
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: characters[index].image.isEmpty
                            ? Container()
                            : Image.network(characters[index].image),
                      ),
                      Text(characters[index].name),
                      Text(
                        characters[index].alternateNames.toList().toString(),
                      ),
                      Text(characters[index].gender),
                      Text(characters[index].house),
                      Text(characters[index].dateOfBirth),
                      Text(characters[index].yearOfBirth.toString()),
                      Text(characters[index].wizard.toString()),
                      Text(characters[index].ancestry),
                      Text(characters[index].eyeColour),
                      Text(characters[index].hairColour),
                      Text(characters[index].wand.toJson().toString()),
                      Text(characters[index].patronus),
                      Text(characters[index].hogwartsStudent.toString()),
                      Text(characters[index].hogwartsStaff.toString()),
                      Text(characters[index].actor),
                      Text(characters[index].species),
                      Text(characters[index].alive.toString()),
                    ],
                  )),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
