class Workflow < ApplicationRecord
  belongs_to :project
  has_many :workflow_subjects
end
