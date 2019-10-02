class Volunteer < ApplicationRecord
  belongs_to :user
  # belongs_to :job
  belongs_to :opportunity, class_name: "Job", foreign_key: "job_id"
  belongs_to :job
end
