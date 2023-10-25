class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });
  late final String id;
  late final String name;
  late final List<String> alternateNames;
  late final String species;
  late final String gender;
  late final String house;
  late final String dateOfBirth;
  late final int yearOfBirth;
  late final bool wizard;
  late final String ancestry;
  late final String eyeColour;
  late final String hairColour;
  late final Wand wand;
  late final String patronus;
  late final bool hogwartsStudent;
  late final bool hogwartsStaff;
  late final String actor;
  late final List<dynamic> alternateActors;
  late final bool alive;
  late final String image;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alternateNames = List.castFrom<dynamic, String>(json['alternate_names']);
    species = json['species'];
    gender = json['gender'];
    house = json['house'];
    dateOfBirth = json['dateOfBirth'];
    yearOfBirth = json['yearOfBirth'];
    wizard = json['wizard'];
    ancestry = json['ancestry'];
    eyeColour = json['eyeColour'];
    hairColour = json['hairColour'];
    wand = Wand.fromJson(json['wand']);
    patronus = json['patronus'];
    hogwartsStudent = json['hogwartsStudent'];
    hogwartsStaff = json['hogwartsStaff'];
    actor = json['actor'];
    alternateActors = List.castFrom<dynamic, dynamic>(json['alternate_actors']);
    alive = json['alive'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['alternate_names'] = alternateNames;
    _data['species'] = species;
    _data['gender'] = gender;
    _data['house'] = house;
    _data['dateOfBirth'] = dateOfBirth;
    _data['yearOfBirth'] = yearOfBirth;
    _data['wizard'] = wizard;
    _data['ancestry'] = ancestry;
    _data['eyeColour'] = eyeColour;
    _data['hairColour'] = hairColour;
    _data['wand'] = wand.toJson();
    _data['patronus'] = patronus;
    _data['hogwartsStudent'] = hogwartsStudent;
    _data['hogwartsStaff'] = hogwartsStaff;
    _data['actor'] = actor;
    _data['alternate_actors'] = alternateActors;
    _data['alive'] = alive;
    _data['image'] = image ?? "";
    return _data;
  }
}

class Wand {
  Wand({
    required this.wood,
    required this.core,
    required this.length,
  });
  late final String wood;
  late final String core;
  late final int length;

  factory Wand.fromJson(Map<String, dynamic> json) {
    final wood = json['wood'] as String?; // Pode ser nulo
    final core = json['core'] as String?; // Pode ser nulo
    final length = json['length']; // Pode ser nulo

    // Verifique se 'length' não é nulo antes de tentar converter
    final lengthValue = length != null
        ? (length as num).toInt()
        : 0; // Use 0 como valor padrão se for nulo

    return Wand(
      wood: wood ?? "", // Use uma string vazia como valor padrão se for nulo
      core: core ?? "", // Use uma string vazia como valor padrão se for nulo
      length: lengthValue,
    );
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wood'] = wood;
    _data['core'] = core;
    _data['length'] = length;
    return _data;
  }
}
