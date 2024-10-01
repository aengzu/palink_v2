import 'package:flutter/material.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:sizing/sizing.dart';
import 'character_profile.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;

  const CharacterList({required this.characters, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        children: characters
            .map((character) => CharacterProfile(character: character))
            .toList(),
    );
  }
}
