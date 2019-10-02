class Favorite < ApplicationRecord
  belongs_to :individual, class_name: "User", foreign_key: "user_id"
  belongs_to :role, class_name: "Job", foreign_key: "job_id"
end
