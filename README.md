# Book Cataloging Application

## Team 10

**Team Members:**

* Amjad Alqahtani
* [Second Team Member Name]

## Project Overview

The Book Cataloging application is a graphical desktop application developed in C# using the Avalonia framework. The application allows users to manage a collection of books through a simple graphical user interface with the following functions: adding, removing, searching, organizing books, and generate reports grouped by genre or author.

## Technologies Used in C#

* C#, .NET, Avalonia UI (Avalonia was selected because the project requires a graphical user interface), LINQ, and Visual Studio Code


## The application supports the following features:

* Add a new book and prevent duplicate books
* Remove a selected book
* Search books by title, author, and genre
* Generate a report grouped by genre and author

## Project Structure

### Models/Book.cs

The `Book` class stores information about each book.

### Services/BookCatalogService.cs

The `BookCatalogService` class contains the main application logic.

The books are stored in a `List<Book>` while the application is running.

### MainWindow.axaml

This file defines the graphical user interface of the application:

* Enter book information, add books, search books, and Display search results
* Remove books and generate reports

### MainWindow.axaml.cs

This file handles user actions from the graphical interface: 

* Add Book button, search button, remove Book button.
* Report by Genre and Author

## Searching

The application supports partial and case-insensitive searching.

For example, if a book is stored with the title:

`Good Boy`

Searching for:

`good`

will return the book `Good Boy`.

## Duplicate Checking

The application prevents duplicate books from being added.

## Reports

### Report by Genre

Books are grouped based on their genre.

Example:

```text
Genre: Fiction (2 books)
- Title: Book One | Author: John Smith | Year: 2020
- Title: Book Two | Author: Sarah Lee | Year: 2022
```

### Report by Author

Books are grouped based on their author.

Example:

```text
Author: John Smith
Number of books: 1 books
- Title: Book One | Genre: Fiction | Year: 2020
```

## How to Run the Application
dotnet new install Avalonia.Templates
dotnet new avalonia.app -o BookCatalogApp
cd BookCatalogApp
dotnet build
dotnet run
