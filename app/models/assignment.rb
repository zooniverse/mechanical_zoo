class Assignment < ApplicationRecord
  BASE_URI = "https://turk.pfe-preview.zooniverse.org/projects"

  scope :complete, -> { where.not(classification_id: nil) }

  belongs_to :hit

  def classify_url(callback_uri)
    query = {
      workflow_id: workflow_id,
      subject_id: subject_id,
      callback: callback_uri.to_s,
      preview: !persisted?
    }

    uri = URI.parse(BASE_URI + "/" + workflow.project_slug + "/turk_classify")
    uri.query = query.to_query
    uri.to_s
  end

  def workflow
    hit.workflow_subject.workflow
  end

  def workflow_id
    hit.workflow_subject.workflow_id
  end

  def subject_id
    hit.workflow_subject.subject_id
  end
end
