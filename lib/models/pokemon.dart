import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    this.effectChanges,
    this.effectEntries,
    this.flavorTextEntries,
    this.generation,
    this.id,
    this.isMainSeries,
    this.name,
    this.names,
    this.pokemon,
  });

  List<EffectChange> effectChanges;
  List<PokemonEffectEntry> effectEntries;
  List<FlavorTextEntry> flavorTextEntries;
  Generation generation;
  int id;
  bool isMainSeries;
  String name;
  List<Name> names;
  List<PokemonElement> pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    effectChanges: List<EffectChange>.from(json["effect_changes"].map((x) => EffectChange.fromJson(x))),
    effectEntries: List<PokemonEffectEntry>.from(json["effect_entries"].map((x) => PokemonEffectEntry.fromJson(x))),
    flavorTextEntries: List<FlavorTextEntry>.from(json["flavor_text_entries"].map((x) => FlavorTextEntry.fromJson(x))),
    generation: Generation.fromJson(json["generation"]),
    id: json["id"],
    isMainSeries: json["is_main_series"],
    name: json["name"],
    names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
    pokemon: List<PokemonElement>.from(json["pokemon"].map((x) => PokemonElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "effect_changes": List<dynamic>.from(effectChanges.map((x) => x.toJson())),
    "effect_entries": List<dynamic>.from(effectEntries.map((x) => x.toJson())),
    "flavor_text_entries": List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
    "generation": generation.toJson(),
    "id": id,
    "is_main_series": isMainSeries,
    "name": name,
    "names": List<dynamic>.from(names.map((x) => x.toJson())),
    "pokemon": List<dynamic>.from(pokemon.map((x) => x.toJson())),
  };
}

class EffectChange {
  EffectChange({
    this.effectEntries,
    this.versionGroup,
  });

  List<EffectChangeEffectEntry> effectEntries;
  Generation versionGroup;

  factory EffectChange.fromJson(Map<String, dynamic> json) => EffectChange(
    effectEntries: List<EffectChangeEffectEntry>.from(json["effect_entries"].map((x) => EffectChangeEffectEntry.fromJson(x))),
    versionGroup: Generation.fromJson(json["version_group"]),
  );

  Map<String, dynamic> toJson() => {
    "effect_entries": List<dynamic>.from(effectEntries.map((x) => x.toJson())),
    "version_group": versionGroup.toJson(),
  };
}

class EffectChangeEffectEntry {
  EffectChangeEffectEntry({
    this.effect,
    this.language,
  });

  String effect;
  Generation language;

  factory EffectChangeEffectEntry.fromJson(Map<String, dynamic> json) => EffectChangeEffectEntry(
    effect: json["effect"],
    language: Generation.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "effect": effect,
    "language": language.toJson(),
  };
}

class Generation {
  Generation({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class PokemonEffectEntry {
  PokemonEffectEntry({
    this.effect,
    this.language,
    this.shortEffect,
  });

  String effect;
  Generation language;
  String shortEffect;

  factory PokemonEffectEntry.fromJson(Map<String, dynamic> json) => PokemonEffectEntry(
    effect: json["effect"],
    language: Generation.fromJson(json["language"]),
    shortEffect: json["short_effect"],
  );

  Map<String, dynamic> toJson() => {
    "effect": effect,
    "language": language.toJson(),
    "short_effect": shortEffect,
  };
}

class FlavorTextEntry {
  FlavorTextEntry({
    this.flavorText,
    this.language,
    this.versionGroup,
  });

  String flavorText;
  Generation language;
  Generation versionGroup;

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) => FlavorTextEntry(
    flavorText: json["flavor_text"],
    language: Generation.fromJson(json["language"]),
    versionGroup: Generation.fromJson(json["version_group"]),
  );

  Map<String, dynamic> toJson() => {
    "flavor_text": flavorText,
    "language": language.toJson(),
    "version_group": versionGroup.toJson(),
  };
}

class Name {
  Name({
    this.language,
    this.name,
  });

  Generation language;
  String name;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    language: Generation.fromJson(json["language"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "language": language.toJson(),
    "name": name,
  };
}

class PokemonElement {
  PokemonElement({
    this.isHidden,
    this.pokemon,
    this.slot,
  });

  bool isHidden;
  Generation pokemon;
  int slot;

  factory PokemonElement.fromJson(Map<String, dynamic> json) => PokemonElement(
    isHidden: json["is_hidden"],
    pokemon: Generation.fromJson(json["pokemon"]),
    slot: json["slot"],
  );

  Map<String, dynamic> toJson() => {
    "is_hidden": isHidden,
    "pokemon": pokemon.toJson(),
    "slot": slot,
  };
}
