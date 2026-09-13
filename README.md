# Book Cataloging Application

## Team 10

**Team Members:**

- Amjad Alqahtani
- Srujana Nevoji

## Project Overview

The application allows users to manage a collection of books through a graphical user interface and it was developed in two programming languages: **C#** and **Ruby**. The goal is to implement the same core functionality in both languages with specific functionalities. The functionalities in our application are adding, removing, searching, organizing, and generating reports for books.

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

- Add a new book and prevent duplicate books
- Remove a selected book, and search books by title, author, or genre
- Partial searching and case-insensitive searching
- Generate reports grouped by genre, or author
- Graphical user interface

---

## Project Structure

The Book class stores information about each book.
* Title, Author, Genre, and Publication Year

### Services/BookCatalogService.cs

The `BookCatalogService` class contains the main application logic:
* Adding removing books
* Duplicate checking and searching
* Grouping books and generating reports

The books are stored in a `List<Book>` while the application is running.

LINQ is used for operations such as:
* Any()
* Where()
* GroupBy()
* OrderBy()

### MainWindow.axaml

This file defines the graphical user interface of the application.

### MainWindow.axaml.cs

This file handles user actions from the graphical interface: 
* Add book button, search button, remove Book button.
* Report by Genre and Author

## Searching

The application supports partial and case-insensitive searching. For example, if a book is stored with the title: `Good Boy`
Searching for: `good` will return the book `Good Boy`.

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

The Ruby version uses: attr_accessor
to provide access to the following attributes:
Title, Author, Genre, and Publication Year

## services/book_catalog_service.rb

The BookCatalogService class contains the main business logic of the Ruby application.

Books are stored in a Ruby:
* Array

The service handles are similar to C#.
The Ruby implementation uses built-in Enumerable methods such as:
* any?
* select
* each
* group_by
* sort_by

These methods demonstrate Ruby's use of blocks and functional-style iteration.

## main.rb

The main.rb file contains the graphical user interface for the Ruby version. Ruby Tk is used to create the GUI. The interface allows users to:
* Enter book information
* Add books
* Search books
* Display search results
* Remove selected books
* Generate reports by genre
* Generate reports by author

## Searching

Both implementations support partial and case-insensitive searching.

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

* Make sure Ruby is installed.
* Check the Ruby version:
* ruby --version

The Ruby version also requires the Tk library. Verify that Tk is working:

* ruby -e "require 'tk'; puts 'Tk works'"
* Navigate to the Ruby project folder:
* cd RubyBookCatalog
* Run the application:

ruby main.rb 

The Ruby Book Catalog graphical interface will open.

## Conclusion

The Book Cataloging Application implemented in two different programming languages. Both C# and Ruby versions provide the same core features, including adding, removing, searching, duplicate checking, and generating reports. The C# version demonstrates strong typing, LINQ, and Avalonia UI, while the Ruby version demonstrates dynamic typing, blocks, Enumerable methods, and Ruby Tk. This project highlights the differences in syntax and programming style between C# and Ruby.
