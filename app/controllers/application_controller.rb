class ApplicationController < ActionController::Base
    helper_method :current_reader, :logged_in?, :sort_direction

    private
      def current_reader
        current_reader ||= Reader.find_by_id(session[:reader_id]) if session[:reader_id]
      end
  
      def logged_in?
        !!current_reader
      end
  
      def redirect_if_not_logged_in
        redirect_to root_path if !logged_in?
      end
  
      def redirect_if_logged_in
        redirect_to reader_path(current_reader) if logged_in?
      end
  
      def redirect_if_not_admin
        redirect_to reader_path(current_reader) if !current_reader.admin
      end
  
      def sort_direction
        %w[asc, desc].include?(params[:direction]) ? params[:direction] : "asc"
      end

end
