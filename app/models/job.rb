class Job < ApplicationRecord
    has_many :volunteers
    has_many :users, through: :volunteers

    has_many :favorites
    has_many :individuals, through: :favorites

    has_many :messages

    belongs_to :user
    
end
