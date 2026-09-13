require_relative '../models/book'

class BookCatalogService
  attr_reader :books

  def initialize
    @books = []
  end

  # Add a new book
  def add_book(book)
    duplicate = @books.any? do |existing_book|
      existing_book.title.casecmp?(book.title) &&
        existing_book.author.casecmp?(book.author) &&
        existing_book.publication_year == book.publication_year
    end

    return false if duplicate

    @books << book
    true
  end

  # Remove a book
  def remove_book(book)
    return false unless @books.include?(book)

    @books.delete(book)
    true
  end

  # Search by title
  def search_by_title(title)
    @books.select do |book|
      book.title.downcase.include?(title.downcase)
    end
  end

  # Search by author
  def search_by_author(author)
    @books.select do |book|
      book.author.downcase.include?(author.downcase)
    end
  end

  # Search by genre
  def search_by_genre(genre)
    @books.select do |book|
      book.genre.downcase.include?(genre.downcase)
    end
  end

  # Generate report by genre
  def report_by_genre
  return "No books." if @books.empty?

  grouped_books = @books.group_by { |book| book.genre }

  grouped_books
    .sort_by { |genre, _books| genre.downcase }
    .map do |genre, books|

      lines = []

      word = books.length == 1 ? "book" : "books"

      lines << "Genre: #{genre} (#{books.length} #{word})"

      books.each do |book|
        lines << "- Title: #{book.title} | Author: #{book.author} | Year: #{book.publication_year}"
      end

      lines.join("\n")
    end
    .join("\n\n")
end

  # Generate report by author
  def report_by_author
    return "No books." if @books.empty?

    grouped_books = @books.group_by { |book| book.author }

    grouped_books
      .sort_by { |author, _books| author.downcase }
      .map do |author, books|

        lines = []
        lines << "Author: #{author}"
        lines << "Number of books: #{books.length}"

        books.each do |book|
          lines << "- Title: #{book.title} | Genre: #{book.genre} | Year: #{book.publication_year}"
        end

        lines.join("\n")
      end
      .join("\n\n")
  end
end