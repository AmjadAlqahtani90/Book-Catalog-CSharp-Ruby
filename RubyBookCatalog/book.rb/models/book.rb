class Book
  attr_accessor :title, :author, :genre, :publication_year

  def initialize(title = "", author = "", genre = "", publication_year = 0)
    @title = title
    @author = author
    @genre = genre
    @publication_year = publication_year
  end

  def to_s
    "#{title} | #{author} | #{genre} | #{publication_year}"
  end
end