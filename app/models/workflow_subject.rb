class WorkflowSubject < ApplicationRecord
  belongs_to :workflow
  has_many :hits
  has_many :assignments, through: :hits
end
