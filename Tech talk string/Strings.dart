import 'package:characters/characters.dart';
void main(){
  String str1="hello";
  String str2="hi";
  //print(str1.length);
  //print(str1.hashCode);
  //print(str1.codeUnits);
  print(str1.padLeft(10,'*'));//It ensures a string reaches a specified length by adding padding to the left side.
  print(str1.padRight(10,'*'));
  print(str1.compareTo(str2));
  print(str2.compareTo(str1));//The compareTo() method in Dart is used to compare two strings lexicographically (i.e., based on dictionary order).
  var raw=r'treats \t,\n,//';
  print(raw);//A raw string treats backslashes (\) and escape sequences as regular characters.
  print(str1.runes);//Runes are used to represent Unicode code points, including symbols outside the basic plane.
  print('😀'.runes);
  print('😀'.codeUnits);
  print('😀'.length);
  print('👨‍👩‍👧‍👦'.runes);
  print('👨‍👩‍👧‍👦'.codeUnits) ;
  print('👨‍👩‍👧‍👦'.length);
  //This emoji is a ZWJ (Zero Width Joiner) sequence, meaning multiple emojis are combined into one visual unit.
  //'👨‍👩‍👧‍👦' consists of individual emojis (👨, 👩, 👧, 👦) joined using ZWJ (\u200D), but Dart treats it as one single grapheme in Unicode.
  print('👨‍👩‍👧‍👦'.characters.length);
  print('👨‍👩‍👧‍👦'.runes.length);                                                                      
  //manually removing ZWJ
  String emoji = '👨‍👩‍👧‍👦'; // Family emoji with ZWJs
  String withoutZWJ = emoji.replaceAll('\u200D', ''); // Removes ZWJ
  print(withoutZWJ);
  //Manually adding ZWJ
  print('न'+'\u200D'+'A'+'\n👨');
  print('न‍A'.characters.length);

  //Separating grapheme clusters
   String text = '👩‍❤️‍💋‍👨 Hi! 👨‍👩‍👧‍👦';

  // Split into grapheme clusters
  List<String> graphemes = text.characters.toList();

  print(graphemes);

  //String buffer
  var buffer = StringBuffer();
buffer.writeln('Hello');
buffer.writeln(' ');
buffer.writeln('World');
print(buffer);  // Hello World

//string equality
String a='apple';
String b='apple';
String c='banana';
print('${a==b} and ${a==c}');
print('${identical(a,b)} ${identical(a,c)} ');

//Null safety
String? name; //tells name can be null to avoid runtime errors
print(name ?? 'Guest');  // if the name is still null after running then print default value Guest

//Conversions
//string to int
int? age = int.tryParse('25') ;  //? why That means the variable receiving the result must be able to hold null.
print(age);         
double price = double.parse('19.99'); 
print(price);
int? safe = int.tryParse('abc') ?? 0;     
print(safe);

//int to string
int aage = 25;
String? ageStr = aage.toString();  
print(ageStr);            

double pi = 3.14159;
String piStr = pi.toStringAsFixed(2);     //Use toStringAsFixed(n) for fixed decimal points.
print(piStr);   

//Regular expression
var emailPattern = RegExp(r'^[\w.-]+@[\w.-]+.\w$');
print(emailPattern.hasMatch('tes.t@exam-ple.com')); // true
//escape characters
print('Hello\' / \"World'); 
//extension
print('hello'.capitalize()); // Hello


}

extension StringUtils on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

