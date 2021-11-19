

import 'package:pokemon_go/models/base_response.dart';

class PokemonResponse extends BaseResponse {
  PokemonResponse({
    status,
    message,
     this.count,
    this.next,
    this.previous,
     this.results,
  }): super(message: message, status: status);


  late final int? count;
  late final String? next;
  late final String? previous;
  late final List<Results>? results;

  PokemonResponse.fromJson(Map<String, dynamic> json){
    status = json['errorStatus'] ?? true;
    message = json['errorMessage'] ?? '' ;
    count = json['count'];
    next = json['next'];
    previous = json['next'];
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['errorStatus'] = status;
    _data['errorMessage'] = message;
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Results {
  Results({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;

  Results.fromJson(Map<String, dynamic> json){
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