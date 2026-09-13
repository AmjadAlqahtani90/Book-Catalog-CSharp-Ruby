require_relative 'models/book'
require_relative 'services/book_catalog_service'

catalog = BookCatalogService.new

# Create sample books
book1 = Book.new(
  "The Hobbit",
  "J.R.R. Tolkien",
  "Fantasy",
  1937
)

book2 = Book.new(
  "1984",
  "George Orwell",
  "Dystopian",
  1949
)

book3 = Book.new(
  "The Fellowship of the Ring",
  "J.R.R. Tolkien",
  "Fantasy",
  1954
)

# Add books
puts "Adding Books"

catalog.add_book(book1)
catalog.add_book(book2)
catalog.add_book(book3)

puts "\nAll Books"

catalog.books.each do |book|
  puts book
end

# Search by title
puts "\nSearch by Title: Hobbit"

catalog.search_by_title("Hobbit").each do |book|
  puts book
end

# Search by author
puts "\nSearch by Author: Tolkien"

catalog.search_by_author("Tolkien").each do |book|
  puts book
end

# Search by genre
puts "\nSearch by Genre: Fantasy"

catalog.search_by_genre("Fantasy").each do |book|
  puts book
end

# Reports
puts "\nReport by Genre"
puts catalog.report_by_genre

puts "\nReport by Author"
puts catalog.report_by_author