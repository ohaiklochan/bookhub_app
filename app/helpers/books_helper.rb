module BooksHelper
    def books_display_header
        if params[:author_id]
          "#{@author.full_name}'s Books"
        elsif params[:genre_id]
          "#{@genre.name}"
        else
          "Books"
        end
      end
    
      def edit_book_link
        if current_reader.admin
          link_to "Edit book", edit_book_path(@book), :class => "btn btn-dark"
        end
      end
    
      def display_average_rating(book)
        if book.reviews.size >= 1
          book.average_rating
        else
          "N/A"
        end
      end
    
      def display_genre(book, genre)
        book_genre = BookGenre.find_book_genre(book, genre).last
    
        content_tag :li do
          if book && current_reader.admin
            (link_to genre.name, genre_books_path(genre)) + " - " + (link_to "delete", book_genre_path(book_genre), :method => :delete)
          else
            link_to genre.name, genre_books_path(genre)
          end
        end
      end
    
      def display_author(book, author)
        book_author = BookAuthor.find_book_author(book, author).last
    
        content_tag :li do
          if book && current_reader.admin
            (link_to author.full_name, author_books_path(author)) + " - " + (link_to "delete", book_author_path(book_author), :method => :delete)
          else
            link_to author.full_name, author_books_path(author)
          end
        end
      end
end
