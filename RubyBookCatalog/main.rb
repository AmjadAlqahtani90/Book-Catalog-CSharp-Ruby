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
    @root = TkRoot.new
    @root.title = "Book Catalog"
    @root.geometry("900x780")

    @main_frame = TkFrame.new(@root)
    @main_frame.pack(
      padx: 20,
      pady: 15,
      fill: 'both',
      expand: true
    )
  end

  def create_title
    title_label = TkLabel.new(@main_frame)
    title_label.text = "Book Cataloging System"
    title_label.font = TkFont.new('Arial 22 bold')
    title_label.pack(
      anchor: 'w',
      pady: [0, 10]
    )
  end

  def create_add_book_section
    frame = TkLabelFrame.new(@main_frame)
    frame.text = "Add Book"
    frame.configure(
      'padx' => 12,
      'pady' => 10
    )
    frame.pack(
      fill: 'x',
      pady: 5
    )

    title_label = TkLabel.new(frame)
    title_label.text = "Title"
    title_label.pack(anchor: 'w')

    @title_entry = TkEntry.new(frame)
    @title_entry.pack(
      fill: 'x',
      pady: [0, 5]
    )

    author_label = TkLabel.new(frame)
    author_label.text = "Author"
    author_label.pack(anchor: 'w')

    @author_entry = TkEntry.new(frame)
    @author_entry.pack(
      fill: 'x',
      pady: [0, 5]
    )

    genre_label = TkLabel.new(frame)
    genre_label.text = "Genre"
    genre_label.pack(anchor: 'w')

    @genre_entry = TkEntry.new(frame)
    @genre_entry.pack(
      fill: 'x',
      pady: [0, 5]
    )

    year_label = TkLabel.new(frame)
    year_label.text = "Publication Year"
    year_label.pack(anchor: 'w')

    @year_entry = TkEntry.new(frame)
    @year_entry.pack(
      fill: 'x',
      pady: [0, 8]
    )

    add_button = TkButton.new(frame)
    add_button.text = "Add Book"
    add_button.command(proc { add_book })
    add_button.pack(anchor: 'w')
  end

  def create_search_section
    frame = TkLabelFrame.new(@main_frame)
    frame.text = "Search Books"
    frame.configure(
      'padx' => 12,
      'pady' => 10
    )
    frame.pack(
      fill: 'x',
      pady: 5
    )

    @search_entry = TkEntry.new(frame)
    @search_entry.pack(
      fill: 'x',
      pady: [0, 8]
    )

    options_frame = TkFrame.new(frame)
    options_frame.pack(fill: 'x')

    search_by_label = TkLabel.new(options_frame)
    search_by_label.text = "Search By:"
    search_by_label.pack(
      side: 'left',
      padx: [0, 10]
    )

    @search_type = TkVariable.new
    @search_type.value = "Title"

    title_radio = TkRadioButton.new(options_frame)
    title_radio.text = "Title"
    title_radio.variable = @search_type
    title_radio.value = "Title"
    title_radio.pack(
      side: 'left',
      padx: 5
    )

    author_radio = TkRadioButton.new(options_frame)
    author_radio.text = "Author"
    author_radio.variable = @search_type
    author_radio.value = "Author"
    author_radio.pack(
      side: 'left',
      padx: 5
    )

    genre_radio = TkRadioButton.new(options_frame)
    genre_radio.text = "Genre"
    genre_radio.variable = @search_type
    genre_radio.value = "Genre"
    genre_radio.pack(
      side: 'left',
      padx: 5
    )

    search_button = TkButton.new(frame)
    search_button.text = "Search"
    search_button.command(proc { search_books })
    search_button.pack(
      anchor: 'w',
      pady: [8, 0]
    )
  end

  def create_results_section
    frame = TkLabelFrame.new(@main_frame)
    frame.text = "Search Results"
    frame.configure(
      'padx' => 12,
      'pady' => 10
    )
    frame.pack(
      fill: 'both',
      pady: 5
    )

    @books_listbox = TkListbox.new(frame)
    @books_listbox.configure(
      'height' => 5,
      'selectmode' => 'single'
    )
    @books_listbox.pack(
      fill: 'both',
      expand: true,
      pady: [0, 8]
    )

    remove_button = TkButton.new(frame)
    remove_button.text = "Remove Selected Book"
    remove_button.command(proc { remove_selected_book })
    remove_button.pack(anchor: 'w')
  end

  def create_reports_section
    frame = TkLabelFrame.new(@main_frame)
    frame.text = "Reports"
    frame.configure(
      'padx' => 12,
      'pady' => 10
    )
    frame.pack(
      fill: 'both',
      pady: 5
    )

    button_frame = TkFrame.new(frame)
    button_frame.pack(
      fill: 'x',
      pady: [0, 8]
    )

    genre_button = TkButton.new(button_frame)
    genre_button.text = "Report by Genre"
    genre_button.command(proc { show_genre_report })
    genre_button.pack(
      side: 'left',
      padx: [0, 10]
    )

    author_button = TkButton.new(button_frame)
    author_button.text = "Report by Author"
    author_button.command(proc { show_author_report })
    author_button.pack(side: 'left')

    @report_text = TkText.new(frame)
    @report_text.configure(
      'height' => 7,
      'wrap' => 'word'
    )
    @report_text.pack(
      fill: 'both',
      expand: true
    )
  end

  def create_status_section
    @status_label = TkLabel.new(@main_frame)
    @status_label.text = ""
    @status_label.font = TkFont.new('Arial 11 bold')
    @status_label.pack(
      anchor: 'w',
      pady: [5, 0]
    )
  end

  def add_book
    title = @title_entry.get.strip
    author = @author_entry.get.strip
    genre = @genre_entry.get.strip
    year_text = @year_entry.get.strip

    if title.empty? ||
       author.empty? ||
       genre.empty? ||
       year_text.empty?

      set_status("Please complete all book fields.")
      return
    end

    unless year_text.match?(/^\d{4}$/)
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
      @displayed_books =
        @catalog.search_by_title(text)

    when "Author"
      @displayed_books =
        @catalog.search_by_author(text)

    when "Genre"
      @displayed_books =
        @catalog.search_by_genre(text)
    end

    update_listbox

    if @displayed_books.empty?
      set_status("No books found.")
    else
      set_status(
        "#{@displayed_books.length} book(s) found."
      )
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
    report = @catalog.report_by_genre

    @report_text.delete(
      '1.0',
      'end'
    )

    @report_text.insert(
      'end',
      report
    )

    set_status("Genre report generated.")
  end

  def show_author_report
    report = @catalog.report_by_author

    @report_text.delete(
      '1.0',
      'end'
    )

    @report_text.insert(
      'end',
      report
    )

    set_status("Author report generated.")
  end

  def refresh_books
    @displayed_books = @catalog.books.dup
    update_listbox
  end

  def update_listbox
    @books_listbox.delete(
      0,
      'end'
    )

    @displayed_books.each do |book|
      display_text =
        "#{book.title} | " \
        "#{book.author} | " \
        "#{book.genre} | " \
        "#{book.publication_year}"

      @books_listbox.insert(
        'end',
        display_text
      )
    end
  end

  def clear_book_fields
    @title_entry.delete(
      0,
      'end'
    )

    @author_entry.delete(
      0,
      'end'
    )

    @genre_entry.delete(
      0,
      'end'
    )

    @year_entry.delete(
      0,
      'end'
    )
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
