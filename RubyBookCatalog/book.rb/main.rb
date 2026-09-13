require_relative 'models/book'
require_relative 'services/book_catalog_service'

catalog = BookCatalogService.new

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

puts "Adding books..."
puts catalog.add_book(book1)
puts catalog.add_book(book2)
puts catalog.add_book(book3)

puts "\nAll Books:"
catalog.books.each do |book|
  puts book
end

puts "\nSearch by Title:"
catalog.search_by_title("hobbit").each do |book|
  puts book
end

puts "\nSearch by Author:"
catalog.search_by_author("tolkien").each do |book|
  puts book
end

puts "\nSearch by Genre:"
catalog.search_by_genre("fantasy").each do |book|
  puts book
end

puts "\nReport by Genre:"
puts catalog.report_by_genre

puts "\nReport by Author:"
puts catalog.report_by_author
