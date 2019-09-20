class User < ApplicationRecord
    has_secure_password

    has_many :volunteers
    has_many :jobs, through: :volunteers
end
