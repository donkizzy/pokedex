
import 'package:pokemon_go/models/base_response.dart';

class PokemonDetailResponse extends BaseResponse{
  PokemonDetailResponse({
     this.height,
     this.id,
     this.name,
     this.order,
     this.sprites,
     this.stats,
     this.weight,
     this.types,
    status,
    message,
  }): super(message: message, status: status);

  late final int? height;
  late final int? id;
  late final String? name;
  late final int? order;
  late final Sprites? sprites;
  late final List<Stats>? stats;
  late final List<Types>? types;
  late final int? weight;

  PokemonDetailResponse.fromJson(Map<String, dynamic> json){
    status = json['errorStatus'] ?? true;
    message = json['errorMessage'] ?? '';
    height = json['height'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    sprites = Sprites.fromJson(Map<String, dynamic>.from(json['sprites']));
    stats = List.from(json['stats']).map((e)=>Stats.fromJson(Map<String, dynamic>.from(e))).toList();
    types = List.from(json['types']).map((e)=>Types.fromJson(Map<String, dynamic>.from(e))).toList();
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['errorStatus'] = status;
    _data['errorMessage'] = message;
    _data['height'] = height;
    _data['id'] = id;
    _data['name'] = name;
    _data['order'] = order;
    _data['sprites'] = sprites!.toJson();
    _data['stats'] = stats!.map((e)=>e.toJson()).toList();
    _data['types'] = types!.map((e)=>e.toJson()).toList();
    _data['weight'] = weight;
    return _data;
  }
}

class Sprites {
  Sprites({
    required this.other,
  });
  late final Other other;

  Sprites.fromJson(Map<String, dynamic> json){
    other = Other.fromJson(Map<String, dynamic>.from(json['other']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['other'] = other.toJson();
    return _data;
  }
}

class Other {
  Other({
    required this.officialArtwork,
  });
  late final OfficialArtwork officialArtwork;

  Other.fromJson(Map<String, dynamic> json){
    officialArtwork = OfficialArtwork.fromJson(Map<String, dynamic>.from(json['official-artwork']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['official-artwork'] = officialArtwork.toJson();
    return _data;
  }
}

class OfficialArtwork {
OfficialArtwork({
  required this.frontDefault,
});
late final String frontDefault;

OfficialArtwork.fromJson(Map<String, dynamic> json){
frontDefault = json['front_default'];
}

Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['front_default'] = frontDefault;
  return _data;
}
}

class Stats {
  Stats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
  late final int baseStat;
  late final int effort;
  late final Stat stat;

  Stats.fromJson(Map<String, dynamic> json){
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = Stat.fromJson(Map<String, dynamic>.from(json['stat']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['base_stat'] = baseStat;
    _data['effort'] = effort;
    _data['stat'] = stat.toJson();
    return _data;
  }
}

class Stat {
  Stat({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;

  Stat.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class Types {
  Types({
    required this.slot,
    required this.type,
  });
  late final int slot;
  late final Type type;

  Types.fromJson(Map<String, dynamic> json){
    slot = json['slot'];
    type = Type.fromJson(Map<String, dynamic>.from(json['type']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slot'] = slot;
    _data['type'] = type.toJson();
    return _data;
  }
}

class Type {
  Type({
    required this.name,
    required this.url,
  });

  late final String name;
  late final String url;

  Type.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}