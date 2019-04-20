package ucm.fdi.android.speechtotext.Items;

import java.util.ArrayList;

public class Book {
    private String title;
    private String author;
    private ArrayList<String> isbnList;
    private String available;

    public Book(String _title, String _author, ArrayList<String> _isbnList){
        title = _title;
        author = _author;
        isbnList = _isbnList;
        available = "";
    }

    public Book(String _title, String _author){
        title = _title;
        author = _author;
        isbnList = new ArrayList<>();
        available = "";
    }

    public Book(String _title, String _author, ArrayList<String> _isbnList, String _available) {
        title = _title;
        author = _author;
        isbnList = _isbnList;
        available = "";
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public ArrayList<String> getISBNList() {
        return isbnList;
    }

    public void setISBNList(ArrayList<String> isbnCode) {
        this.isbnList = isbnCode;
    }

    public String getAvailable(){
        return this.available;
    }

    public void setAvailable(String available){
        this.available = available;
    }
}
