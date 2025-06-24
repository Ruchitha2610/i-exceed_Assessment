import 'package:characters/characters.dart';
void main(){
  //unicodes,runes,codeUnits,emojis
  print('😀'.runes);
  print('😀'.codeUnits);
  print('😀'.length);

  //Zero Width Joiner
  print('👨‍👩‍👧‍👦'.runes);
  print('👨‍👩‍👧‍👦'.codeUnits) ;
  print('👨‍👩‍👧‍👦'.length);

  print('👨‍👩‍👧‍👦'.runes.length); 
  print('👨‍👩‍👧‍👦'.characters.length);
  
  String emoji = '👨‍👩‍👧‍👦'; // Family emoji with ZWJs
  String withoutZWJ = emoji.replaceAll('\u200D', ''); // Removes ZWJ
  print(withoutZWJ);

  print("\u0CA8");
}