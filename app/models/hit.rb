class Hit < ApplicationRecord
  belongs_to :workflow_subject
  has_many :assignments
end
