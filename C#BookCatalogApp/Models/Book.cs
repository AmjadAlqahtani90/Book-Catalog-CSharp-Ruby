namespace BookCatalogApp.Models;
public class Book {
    private string title = "";
    private string author = "";
    private string genre = "";
    private int publicationYear;
    public string Title {
        get { return title; }
        set { title = value; }
    }
    public string Author {
        get { return author; }
        set { author = value; }
    }
    public string Genre {
        get { return genre; }
        set { genre = value; }
    }
    public int PublicationYear {
        get { return publicationYear; }
        set { publicationYear = value; }
    }
    public Book(string title, string author, string genre, int publicationYear) {
        Title = title;
        Author = author;
        Genre = genre;
        PublicationYear = publicationYear;
    }
    public Book() {}
}