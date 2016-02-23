class Post < ActiveRecord::Base

    # Validates presence - invalid if nil or empty
    validates :title, presence: true

    # Validates that this is a number
    validates :category, numericality: false

    # Validates that this value is in a list
    validates :category, presence: true

    def lead
        content.to_s.first(100) + "..."
    end
    
    def to_s
        self.title
    end
    
    def by?(author)
       self.author == author
    end

    def self.entitled(value)
        # let's make search NOT case-sensitive
        where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{value.downcase}%", "%#{value.downcase}%")
        # where(title: value)

    end
    
    def same_category?(other)
       self.category == other.category
    end
end
