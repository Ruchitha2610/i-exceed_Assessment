import java.io.*;

class filecreation {
    public static void main(String[] args) throws IOException {
        File file = new File("file.txt");

       
        boolean created = file.createNewFile();

        if (created) {
            System.out.println("file created.");
        } else {
            System.out.println(" file already exists.");
        }

       
        System.out.println("\nFile Info:");
        System.out.println("Name: " + file.getName());
        System.out.println("Path: " + file.getAbsolutePath());
        System.out.println("Is Absolute Path: " + file.isAbsolute());

        if (file.exists()) {
            System.out.println("Readable: " + file.canRead());
            System.out.println("Writable: " + file.canWrite());
        }

        
        if (file.delete()) {
            System.out.println("\nfile deleted successfully.");
        } else {
            System.out.println("\nFailed to delete the file.");
        }

        System.out.println("File still exists? " + file.exists());
    }
}
