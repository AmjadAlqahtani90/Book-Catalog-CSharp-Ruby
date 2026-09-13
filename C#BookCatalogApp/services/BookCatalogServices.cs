using System;
using System.Collections.Generic;
using System.Linq;
using BookCatalogApp.Models;
namespace BookCatalogApp.Services;
public class BookCatalogService
{
    private readonly List<Book> books = new List<Book>();
    public bool AddBook(Book book) { 
        bool duplicate = books.Any(b =>
            b.Title.Equals(book.Title, StringComparison.OrdinalIgnoreCase) &&
            b.Author.Equals(book.Author, StringComparison.OrdinalIgnoreCase) &&
            b.PublicationYear == book.PublicationYear);
        
        if (duplicate){ return false;}
        books.Add(book);
        return true;
    }
    public bool RemoveBook(Book book) {
        return books.Remove(book);
    }
    public List<Book> SearchByTitle(string title) {
        return books.Where(book => book.Title.Contains( 
            title, StringComparison.OrdinalIgnoreCase)).ToList();
    }
    public List<Book> SearchByAuthor(string author) {
        return books.Where(book => book.Author.Contains(
            author,StringComparison.OrdinalIgnoreCase)).ToList();
    }
    public List<Book> SearchByGenre(string genre) {
        return books.Where(book => book.Genre.Contains(
                    genre,StringComparison.OrdinalIgnoreCase)).ToList();
    }
    public string ReportByGenre() {
        if (books.Count == 0){
            return "No books.";
        }
        var groups = books.GroupBy(book => book.Genre);
        var sortedGroups = groups.OrderBy(group => group.Key);
        string report = "";
        foreach (var group in sortedGroups) {
            string word = group.Count() == 1 ? "book" : "books";
            report += "Genre: " + group.Key + " (" + group.Count() + " " + word + ")\n";
            foreach (var book in group){
                report += "- Title: " + book.Title + " | Author: " + book.Author +  " | Year: " + book.PublicationYear + "\n";
            }
            report += "\n";
        }
        return report;
    }
    public string ReportByAuthor() {
        if (books.Count == 0) {
            return "No books.";
        }
        var groups = books.GroupBy(book => book.Author);
        var sortedgroups = groups.OrderBy(group => group.Key);
        string report = "";
        foreach (var group in sortedgroups){
            string word = group.Count() == 1 ? "book" : "books";
            report += "Author: " + group.Key + "\n";
            report += "Number of books: " + group.Count() + " " + word + "\n";
            foreach (var book in group) {
                report += "- Title: " + book.Title + " | Genre: " + book.Genre +  " | Year: " + book.PublicationYear + "\n";
            }
            report += "\n";
        }
        return report;
    }
}