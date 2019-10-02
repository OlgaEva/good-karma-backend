class Message < ApplicationRecord
    belongs_to :messenger, class_name: 'User'
    belongs_to :messagee, class_name: 'User'
    belongs_to :job, class_name: 'Job'
end
