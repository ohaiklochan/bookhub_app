class ApplicationController < ActionController::Base
    helper_method :current_reader, :logged_in?, :validate, :owned_by_reader?, :email_striper, :current_book

    def current_reader
        @current_reader ||= Reader.find_by_id(session[:reader_id])
    end

    def logged_in?
        !!current_reader
    end


    def validate 
        unless @reader.id == current_reader.id 
            flash[:error] = "You do not have access."
            redirect_to book_path
        end
    end 

    def owned_by_reader?(books) 
        if @book!= nil 
            if current_reader.id == @book.reader_id
                return true 
            else 
                false 
            end
        end
    end


    def email_striper(email)
        username = email.split(/@gmail.com/)
        username[0]
    end

    def current_book
        @book = Book.find_by_id(params[:id])
    end

end
