class User < ApplicationRecord
    has_secure_password

    has_many :volunteers
    has_many :opportunities, through: :volunteers, source: :job

    has_many :favorites
    has_many :roles, through: :favorites

    has_many :jobs

    has_many :messaged_users, foreign_key: :messenger_id, class_name: 'Message'
    has_many :messagees, through: :messaged_users

    has_many :messaging_users, foreign_key: :messagee_id, class_name: 'Message'
    has_many :messengers, through: :messaging_users
end
