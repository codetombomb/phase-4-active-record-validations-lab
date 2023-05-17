class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: { in: ["Fiction", "Non-Fiction"]}

    validate :filter_clickbait

    def filter_clickbait
        clickbait = ["Won't Believe", "Secret","Top [number]","Guess"] # Possible matches
        contains_bait = !!clickbait.find do |bait| # If any clickbait string matches, return that value and save it to the contains_bait variable as a truthy/falsey value
            if !self.title.nil? # Check for an existing title so it doesn't error out
                self.title.include? bait # Check to see if that title contains matching clickbait
            end
        end

        if !contains_bait # If the title does not have clickbait, add more cowbell
            errors.add(:title, "Needs more cowbell")
        end
    end
end
