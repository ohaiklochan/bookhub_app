class AuthorsController < ApplicationController
    helper_method :sort_column

    def index
      set_authors_array
      @book = Book.find_by_id(params[:id])
    end
  
    def show
      @author = Author.find_by_id(params[:id])
    end
  
    private
  
      def set_authors_array
        if params[:first_name] && params[:last_name] == ""
          @authors = Author.find_by_first_name(params[:first_name])
        elsif params[:first_name] == "" && params[:last_name]
          @authors = Author.find_by_last_name(params[:last_name])
        elsif params[:first_name] && params[:last_name]
          @authors = Author.find_by_first_name(params[:first_name]) && Author.find_by_last_name(params[:last_name])
        else
          @authors = Author.order(sort_column + " " + sort_direction)
        end
      end
  
      def sort_column
        Author.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
      end
end
