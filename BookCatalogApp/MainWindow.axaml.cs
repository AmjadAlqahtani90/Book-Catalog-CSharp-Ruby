using System.Collections.Generic;
using Avalonia.Controls;
using Avalonia.Interactivity;
using BookCatalogApp.Models;
using BookCatalogApp.Services;

namespace BookCatalogApp;
public partial class MainWindow : Window {
    private readonly BookCatalogService catalogService;
    public MainWindow(){
        InitializeComponent();

        catalogService = new BookCatalogService();
    }
    private void AddBook_Click(object? sender, RoutedEventArgs e) {
        string title = TitleTextBox.Text?.Trim() ?? "";
        string author = AuthorTextBox.Text?.Trim() ?? "";
        string genre = GenreTextBox.Text?.Trim() ?? "";
        string yearText = YearTextBox.Text?.Trim() ?? "";

        if (string.IsNullOrWhiteSpace(title)) {
            StatusTextBlock.Text = "enter title.";
            return;
        }

        if (string.IsNullOrWhiteSpace(author)) {
            StatusTextBlock.Text = "enter author.";
            return;
        }

        if (string.IsNullOrWhiteSpace(genre)) {
            StatusTextBlock.Text = "enter genre.";
            return;
        }

        if (!int.TryParse(yearText, out int publicationYear)){
            StatusTextBlock.Text =
                "valid number.";

            return;
        }

        Book book = new() {
            Title = title,
            Author = author,
            Genre = genre,
            PublicationYear = publicationYear
        };

        bool added = catalogService.AddBook(book);
        if (!added) {
            StatusTextBlock.Text = "This book already exists.";
            return;
        }
        StatusTextBlock.Text = "Book added successfully.";
        ShowPrompt($"'{book.Title}' was added successfully.");
        ClearBookFields();
    }

    private void Search_Click(object? sender, RoutedEventArgs e) {
        string searchText =
            SearchTextBox.Text?.Trim() ?? "";

        if (string.IsNullOrWhiteSpace(searchText))
        {
            StatusTextBlock.Text =
                "Enter something to search for.";

            BooksListBox.ItemsSource = null;

            return;
        }

        ComboBoxItem? selectedItem =
            SearchByComboBox.SelectedItem as ComboBoxItem;

        string searchType =
            selectedItem?.Content?.ToString() ?? "Title";

        List<Book> results;

        switch (searchType)
        {
            case "Author":

                results =
                    catalogService.SearchByAuthor(searchText);

                break;

            case "Genre":

                results =
                    catalogService.SearchByGenre(searchText);

                break;

            default:

                results =
                    catalogService.SearchByTitle(searchText);

                break;
        }

        BooksListBox.ItemsSource = results;

        StatusTextBlock.Text =
            $"{results.Count} book(s) found.";
    }

    private void RemoveBook_Click(
        object? sender,
        RoutedEventArgs e)
    {
        if (BooksListBox.SelectedItem is not Book selectedBook)
        {
            StatusTextBlock.Text =
                "Select a book from the search results first.";

            return;
        }

        bool removed =
            catalogService.RemoveBook(selectedBook);

        if (removed)
        {
            ShowPrompt($"'{selectedBook.Title}' was removed successfully.");

            BooksListBox.ItemsSource = null;
        }
    }
    private void ReportByGenre_Click(object? sender,RoutedEventArgs e) {
        ReportTextBox.Text =
            catalogService.ReportByGenre();
    }
    private void ReportByAuthor_Click(object? sender,RoutedEventArgs e) {
        ReportTextBox.Text =
            catalogService.ReportByAuthor();
    }
    private void ClearBookFields() {
        TitleTextBox.Text = "";
        AuthorTextBox.Text = "";
        GenreTextBox.Text = "";
        YearTextBox.Text = "";
    }

private async void ShowPrompt(string message){
    var dialog = new Window {
        Title = "Book Catalog",
        Width = 350,
        Height = 150,
        WindowStartupLocation = WindowStartupLocation.CenterOwner
    };

    var okButton = new Button {
        Content = "OK",
        HorizontalAlignment = Avalonia.Layout.HorizontalAlignment.Center
    };

    okButton.Click += (_, _) => dialog.Close();

    dialog.Content = new StackPanel {
        Margin = new Avalonia.Thickness(20),
        Spacing = 20,
        Children =
        {
            new TextBlock{
                Text = message,
                TextWrapping = Avalonia.Media.TextWrapping.Wrap,
                HorizontalAlignment =
                    Avalonia.Layout.HorizontalAlignment.Center
            },
            okButton
        }
    };

    await dialog.ShowDialog(this);
    }
}