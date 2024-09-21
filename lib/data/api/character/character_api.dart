import 'package:dio/dio.dart';
import 'package:palink_v2/data/models/character/character_response.dart';
import 'package:palink_v2/data/models/character/characters_response.dart';
import 'package:palink_v2/data/models/tip/tip_create_request.dart';
import 'package:palink_v2/data/models/tip/tip_response.dart';
import 'package:retrofit/http.dart';

part 'character_api.g.dart';


@RestApi()
abstract class CharacterApi {
  factory CharacterApi(Dio dio, {String baseUrl}) = _CharacterApi;

  @GET("/characters")
  Future<CharactersResponse> getAllCharacters();

  @GET("/characters/{character_id}")
  Future<CharacterResponse> getCharacterById(@Path("character_id") int characterId);

}
