void main(){
  //raw strings and regular expression
  var raw=r'treats \t,\n,// as string';
  print(raw);

  var emailPattern = RegExp(r'^[\w.-]+@[\w.-]+.\w$');
  print(emailPattern.hasMatch('tes.t@exam-ple.com')); 

  //String buffer
  var buffer = StringBuffer();
  buffer.writeln('Hello');
  buffer.writeln(' ');
  buffer.writeln('World');
  print(buffer);

  //string equality
  String a='apple';
  String b='apple';
  String c='banana';
  print('${a==b} and ${a==c}');
  print('${identical(a,b)} ${identical(a,c)} ');

  //Null safety
  String? name; 
  print(name ?? 'Guest');

}