
void main(){
  String str1="hello";
  String str2="hi";

  //properties
  print(str1.length);
  print(str1.isEmpty);
  print(str1.isNotEmpty);
  print(str1.hashCode);
  print(str1.codeUnits);
  print(str1.runes);

  //Methods
  print('hello'.toUpperCase());
  print('WORLD'.toLowerCase());
  print('flutter'.contains('lut'));
  print( 'flutter'.startsWith('flu'));
  print('flutter'.endsWith('ter'));
  print('developer'.substring(0, 4));
  print('developer'.indexOf('e'));
  print('developer'.lastIndexOf('e'));
  print(str1.padLeft(10,'*'));
  print(str1.padRight(10,'*'));
  print(str1.compareTo(str2));
  print(str2.compareTo(str1));
  print('hello world'.split(' '));
  print('  dart  '.trim());
  print('banana'.replaceAll('a', 'o'));
  print('banana'.replaceFirst('a', 'o'));
  print('banana'.replaceRange(1, 4, 'xyz'));
  print('hello'.codeUnitAt(1));
}

