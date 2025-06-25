//MultiLevel Inheritence:a class inherits from another derived class
class Library{
  String? library_name;
  Library(String? library_name){
    this.library_name=library_name;
  }
  void displayLibrary(){
    print("Nmae of library: $library_name");
  }
}

class Book extends Library{
  String? title;
  Book(String? library_name,String? title):super(library_name){
    this.title=title;
  }
  void displayBook(){
    print('Book title: $title');
  }
}
class Reader extends Book{
  String? reader_name;
  Reader(String library_name,String title,String reader_name):super(library_name,title){
    this.reader_name=reader_name;
  }
  void displayReader(){
    print("Reader: $reader_name");
  }
}
void main(){
  Reader r=Reader("Corporation Library","Dart","anjali");
  r.displayReader();
  r.displayLibrary();
  r.displayBook();
  
  Reader r1=Reader("Bangalore Library","Java","anitha");
  r1.displayReader();
  r1.displayLibrary();
  r1.displayBook();
}