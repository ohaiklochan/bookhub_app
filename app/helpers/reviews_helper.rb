module ReviewsHelper

    def new_review_header
        if @review.book
          "New Review for #{@review.book.title}"
        else
          "New Review"
        end
    end
    
    def reviews_display_header
        if params[:reader_id] && current_reader.id.to_s == params[:reader_id]
          "Your Reviews"
        elsif params[:reader_id] && @reader
          "#{@reader.username}'s Reviews"
        elsif params[:book_id] && @book
          "#{@book.title} Reviews"
        else
          "All book Reviews"
        end
    end
    
    def display_review_title_link(review)
        (link_to "#{review.title}", review_path(review)).html_safe + tag(:br) if !params[:id]
    end
    
    def display_book_link_in_review(review)
        "book: #{link_to review.book.title, book_path(review.book)}".html_safe + tag(:br) if !params[:book_id]
    end
      
    def display_reader_link_in_review(review)
        "Written by: #{link_to review.reader.username, reader_reviews_path(review.reader)}".html_safe + tag(:br) if !params[:reader_id]
    end
    
    def review_date(review)
        review.created_at.strftime("%B %d, %Y")
    end
    
    def display_review_content(review)
        params[:id] ? review.content : review.content.truncate(350)
    end
    
    def display_edit_and_delete_links(review)
        if current_reader.id.to_s == params[:reader_id] || current_reader.id == review.reader.id
          "#{link_to "Edit Review", edit_review_path(review)} |
          #{link_to "Delete Review", review_path(review), :method => :delete}".html_safe + tag(:br)
        end
    end
    
    def write_review_for_book_link
        link_to "Write a Review", new_book_review_path(@book), :class => "btn btn-dark" if params[:book_id] && @book
    end
    
    def no_reviews_message
        content_tag :span, "Be the first to review #{@book.title}.".html_safe + tag(:br) + tag(:br) if @reviews.empty?
    end

end
