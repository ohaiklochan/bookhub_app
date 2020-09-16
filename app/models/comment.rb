class Comment < ApplicationRecord
    belongs_to :user 
    belongs_to :review
    scope :most_recent, -> {Comment.order("created_at DESC")}
    # review scopes


    def self.deleted_user
        Comment.all.each do |comment|
            if comment.user == nil
                comment.destroy 
            end
        end 
    end 


    def normalize_date
        self.created_at = created_at.strftime("%B %-d, %Y %-l:%M %p")
    end 

end
