# Book Cataloging Application

## Team 10

**Team Members:**

- Amjad Alqahtani
- Srujana Nevoji

## Project Overview

The Book Cataloging Application is a graphical desktop application developed in two programming languages: **C#** and **Ruby**.

The purpose of the project is to implement the same core functionality in both languages while demonstrating language-specific programming features.

The application allows users to manage a collection of books through a graphical user interface. Users can add, remove, search, organize, and generate reports for books.

Each book stores the following information:

- Title
- Author
- Genre
- Publication Year

Both implementations provide the same core functionality while using different language features and GUI technologies.

---

## Technologies Used

### C# Version

- C#
- .NET
- Avalonia UI
- LINQ
- Visual Studio Code

Avalonia UI was selected because the project requires a graphical user interface.

### Ruby Version

- Ruby
- Ruby Tk
- Arrays
- Blocks
- Enumerable methods
- Visual Studio Code

Ruby Tk is used to create the graphical user interface for the Ruby version.

---

## Application Features

Both the C# and Ruby versions support the following features:

- Add a new book
- Prevent duplicate books
- Remove a selected book
- Search books by title
- Search books by author
- Search books by genre
- Partial searching
- Case-insensitive searching
- Generate reports grouped by genre
- Generate reports grouped by author
- Graphical user interface

---

## Project Structure

The repository contains both the C# and Ruby implementations.

```text
Book-Catalog-CSharp-Ruby/
│
├── C#BookCatalogApp/
│   ├── Models/
│   │   └── Book.cs
│   ├── Services/
│   │   └── BookCatalogService.cs
│   ├── .gitgnore
│   ├── App.axaml
│   ├── app.manifest
│   ├── BookCataloApp
│   ├── MainWindow.axaml 
│   ├── MainWindow.axaml.cs
│   └── Program.cs
│
├── RubyBookCatalog/
│   ├── models/
│   │   └── book.rb
│   ├── services/
│   │   └── book_catalog_service.rb
│   └── main.rb
│
├── Book-Catalog-CSharp-Ruby.sln
└── README.md

### Models/Book.cs

The Book class stores information about each book.

The class contains the following properties:

Title
Author
Genre
Publication Year

### Services/BookCatalogService.cs

The `BookCatalogService` class contains the main application logic.

The books are stored in a `List<Book>` while the application is running.

The service handles:

Adding books
Removing books
Duplicate checking
Searching
Grouping books
Generating reports

LINQ is used for operations such as:

Any()
Where()
GroupBy()
OrderBy()

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

## How to Run the C# Application
* dotnet new install Avalonia.Templates
* dotnet new avalonia.app -o BookCatalogApp
* cd BookCatalogApp
* dotnet build
* dotnet run

### Ruby Implementation
## models/book.rb

The Book class stores the information for each book.

The Ruby version uses:
attr_accessor

to provide access to the following attributes:

Title
Author
Genre
Publication Year

## services/book_catalog_service.rb

The BookCatalogService class contains the main business logic of the Ruby application.

Books are stored in a Ruby:
Array

The service handles:

Adding books
Removing books
Duplicate checking
Searching
Grouping books
Generating reports

The Ruby implementation uses built-in Enumerable methods such as:

any?
select
each
group_by
sort_by

These methods demonstrate Ruby's use of blocks and functional-style iteration.

## main.rb

The main.rb file contains the graphical user interface for the Ruby version.

Ruby Tk is used to create the GUI.

The interface allows users to:

Enter book information
Add books
Search books
Display search results
Remove selected books
Generate reports by genre
Generate reports by author

## Searching

Both implementations support partial and case-insensitive searching.

For example, if a book is stored with the title:

Good Boy

Searching for:

good

will return:

Good Boy

Books can be searched by:

Title
Author
Genre

## Duplicate Checking

Both implementations prevent duplicate books from being added.

A book is considered a duplicate when the following values match:

Title
Author
Publication Year

The title and author comparisons are case-insensitive.

## Reports
# Report by Genre

Books are grouped based on their genre.

Example:

Genre: Fiction (2 books)

- Title: Book One | Author: John Smith | Year: 2020
- Title: Book Two | Author: Sarah Lee | Year: 2022
# Report by Author

Books are grouped based on their author.

Example:

Author: John Smith

Number of books: 1 book

- Title: Book One | Genre: Fiction | Year: 2020

## How to Run the Ruby Application

Make sure Ruby is installed.

Check the Ruby version:

ruby --version

The Ruby version also requires the Tk library.

Verify that Tk is working:

ruby -e "require 'tk'; puts 'Tk works'"

Navigate to the Ruby project folder:

cd RubyBookCatalog

Run the application:

ruby main.rb

The Ruby Book Catalog graphical interface will open.

## Conclusion

The Book Cataloging Application demonstrates how the same software requirements can be implemented using two different programming languages.

Both C# and Ruby versions provide the same core features, including adding, removing, searching, duplicate checking, and generating reports.

The C# version demonstrates strong typing, LINQ, and Avalonia UI, while the Ruby version demonstrates dynamic typing, blocks, Enumerable methods, and Ruby Tk.

This project highlights the differences in syntax and programming style between C# and Ruby while maintaining equivalent application functionality.