require_relative '../models/book'

class BookCatalogService
  attr_reader :books

  def initialize
    @books = []
  end

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

  def remove_book(book)
    return false unless @books.include?(book)

    @books.delete(book)
    true
  end

  def search_by_title(title)
    @books.select do |book|
      book.title.downcase.include?(title.downcase)
    end
  end

  def search_by_author(author)
    @books.select do |book|
      book.author.downcase.include?(author.downcase)
    end
  end

  def search_by_genre(genre)
    @books.select do |book|
      book.genre.downcase.include?(genre.downcase)
    end
  end

  def report_by_genre
    return "No books." if @books.empty?

    grouped_books = @books.group_by { |book| book.genre }
    sorted_groups = grouped_books.sort_by { |genre, _| genre.downcase }

    report = ""

    sorted_groups.each do |genre, books|
      word = books.count == 1 ? "book" : "books"

      report += "Genre: #{genre} (#{books.count} #{word})\n"

      books.each do |book|
        report += "- Title: #{book.title} | " \
                  "Author: #{book.author} | " \
                  "Year: #{book.publication_year}\n"
      end

      report += "\n"
    end

    report
  end

  def report_by_author
    return "No books." if @books.empty?

    grouped_books = @books.group_by { |book| book.author }
    sorted_groups = grouped_books.sort_by { |author, _| author.downcase }

    report = ""

    sorted_groups.each do |author, books|
      word = books.count == 1 ? "book" : "books"

      report += "Author: #{author}\n"
      report += "Number of books: #{books.count} #{word}\n"

      books.each do |book|
        report += "- Title: #{book.title} | " \
                  "Genre: #{book.genre} | " \
                  "Year: #{book.publication_year}\n"
      end

      report += "\n"
    end

    report
  end
end