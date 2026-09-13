require 'tk'
require_relative 'models/book'
require_relative 'services/book_catalog_service'

class BookCatalogGUI
  def initialize
    @catalog = BookCatalogService.new
    @displayed_books = []

    create_window
    create_title
    create_add_book_section
    create_search_section
    create_results_section
    create_reports_section
    create_status_section

    refresh_books
  end

  def create_window
    @root = TkRoot.new do
      title "Book Catalog"
      geometry "900x780"
    end

    @main_frame = TkFrame.new(@root)
    @main_frame.pack(
      padx: 20,
      pady: 15,
      fill: 'both',
      expand: true
    )
  end

  def create_title
    TkLabel.new(@main_frame) do
      text "Book Cataloging System"
      font TkFont.new('Arial 22 bold')
      pack(
        anchor: 'w',
        pady: [0, 10]
      )
    end
  end

  def create_add_book_section
    frame = TkLabelFrame.new(@main_frame) do
      text "Add Book"
      padx 12
      pady 10
      pack(
        fill: 'x',
        pady: 5
      )
    end

    TkLabel.new(frame) do
      text "Title"
      pack(anchor: 'w')
    end

    @title_entry = TkEntry.new(frame) do
      pack(fill: 'x', pady: [0, 5])
    end

    TkLabel.new(frame) do
      text "Author"
      pack(anchor: 'w')
    end

    @author_entry = TkEntry.new(frame) do
      pack(fill: 'x', pady: [0, 5])
    end

    TkLabel.new(frame) do
      text "Genre"
      pack(anchor: 'w')
    end

    @genre_entry = TkEntry.new(frame) do
      pack(fill: 'x', pady: [0, 5])
    end

    TkLabel.new(frame) do
      text "Publication Year"
      pack(anchor: 'w')
    end

    @year_entry = TkEntry.new(frame) do
      pack(fill: 'x', pady: [0, 8])
    end

    TkButton.new(frame) do
      text "Add Book"
      command proc { add_book }
      pack(anchor: 'w')
    end
  end

  def create_search_section
    frame = TkLabelFrame.new(@main_frame) do
      text "Search Books"
      padx 12
      pady 10
      pack(
        fill: 'x',
        pady: 5
      )
    end

    @search_entry = TkEntry.new(frame) do
      pack(fill: 'x', pady: [0, 8])
    end

    options_frame = TkFrame.new(frame)
    options_frame.pack(fill: 'x')

    TkLabel.new(options_frame) do
      text "Search By:"
      pack(side: 'left', padx: [0, 10])
    end

    @search_type = TkVariable.new
    @search_type.value = "Title"

    TkRadioButton.new(options_frame) do
      text "Title"
      variable @search_type
      value "Title"
      pack(side: 'left', padx: 5)
    end

    TkRadioButton.new(options_frame) do
      text "Author"
      variable @search_type
      value "Author"
      pack(side: 'left', padx: 5)
    end

    TkRadioButton.new(options_frame) do
      text "Genre"
      variable @search_type
      value "Genre"
      pack(side: 'left', padx: 5)
    end

    TkButton.new(frame) do
      text "Search"
      command proc { search_books }
      pack(anchor: 'w', pady: [8, 0])
    end
  end

  def create_results_section
    frame = TkLabelFrame.new(@main_frame) do
      text "Search Results"
      padx 12
      pady 10
      pack(
        fill: 'both',
        pady: 5
      )
    end

    @books_listbox = TkListbox.new(frame) do
      height 5
      selectmode 'single'
      pack(
        fill: 'both',
        expand: true,
        pady: [0, 8]
      )
    end

    TkButton.new(frame) do
      text "Remove Selected Book"
      command proc { remove_selected_book }
      pack(anchor: 'w')
    end
  end

  def create_reports_section
    frame = TkLabelFrame.new(@main_frame) do
      text "Reports"
      padx 12
      pady 10
      pack(
        fill: 'both',
        pady: 5
      )
    end

    button_frame = TkFrame.new(frame)
    button_frame.pack(fill: 'x', pady: [0, 8])

    TkButton.new(button_frame) do
      text "Report by Genre"
      command proc { show_genre_report }
      pack(side: 'left', padx: [0, 10])
    end

    TkButton.new(button_frame) do
      text "Report by Author"
      command proc { show_author_report }
      pack(side: 'left')
    end

    @report_text = TkText.new(frame) do
      height 7
      wrap 'word'
      pack(
        fill: 'both',
        expand: true
      )
    end
  end

  def create_status_section
    @status_label = TkLabel.new(@main_frame) do
      text ""
      font TkFont.new('Arial 11 bold')
      pack(
        anchor: 'w',
        pady: [5, 0]
      )
    end
  end

  def add_book
    title = @title_entry.get.strip
    author = @author_entry.get.strip
    genre = @genre_entry.get.strip
    year_text = @year_entry.get.strip

    if title.empty? || author.empty? || genre.empty? || year_text.empty?
      set_status("Please complete all book fields.")
      return
    end

    unless year_text =~ /^\d{4}$/
      set_status("Publication year must be a four-digit number.")
      return
    end

    book = Book.new(
      title,
      author,
      genre,
      year_text.to_i
    )

    if @catalog.add_book(book)
      set_status("Book added successfully.")
      clear_book_fields
      refresh_books
    else
      set_status("Duplicate book already exists.")
    end
  end

  def search_books
    text = @search_entry.get.strip

    if text.empty?
      set_status("Enter search text.")
      return
    end

    case @search_type.value
    when "Title"
      @displayed_books = @catalog.search_by_title(text)
    when "Author"
      @displayed_books = @catalog.search_by_author(text)
    when "Genre"
      @displayed_books = @catalog.search_by_genre(text)
    end

    update_listbox

    if @displayed_books.empty?
      set_status("No books found.")
    else
      set_status("#{@displayed_books.length} book(s) found.")
    end
  end

  def remove_selected_book
    selection = @books_listbox.curselection

    if selection.nil? || selection.empty?
      set_status("Select a book to remove.")
      return
    end

    index = selection.first.to_i
    book = @displayed_books[index]

    if book && @catalog.remove_book(book)
      set_status("Removed: #{book.title}")
      refresh_books
    else
      set_status("Unable to remove selected book.")
    end
  end

  def show_genre_report
    @report_text.delete('1.0', 'end')
    @report_text.insert('end', @catalog.report_by_genre)
    set_status("Genre report generated.")
  end

  def show_author_report
    @report_text.delete('1.0', 'end')
    @report_text.insert('end', @catalog.report_by_author)
    set_status("Author report generated.")
  end

  def refresh_books
    @displayed_books = @catalog.books.dup
    update_listbox
  end

  def update_listbox
    @books_listbox.delete(0, 'end')

    @displayed_books.each do |book|
      @books_listbox.insert(
        'end',
        "#{book.title} | #{book.author} | #{book.genre} | #{book.publication_year}"
      )
    end
  end

  def clear_book_fields
    @title_entry.delete(0, 'end')
    @author_entry.delete(0, 'end')
    @genre_entry.delete(0, 'end')
    @year_entry.delete(0, 'end')
  end

  def set_status(message)
    @status_label.text = message
  end

  def run
    Tk.mainloop
  end
end

app = BookCatalogGUI.new
app.run