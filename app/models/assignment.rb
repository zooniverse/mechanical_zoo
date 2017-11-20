class Assignment < ApplicationRecord
  BASE_URI = "https://898a7294.eu.ngrok.io/projects/brooke/i-fancy-cats/turk_classify"

  scope :complete, -> { where.not(classification_id: nil) }

  belongs_to :hit

  def classify_url
    callback_uri = URI.parse("https://898a7294.eu.ngrok.io/turk/classify/callback/#{id}")

    query = {
      workflow_id: hit.workflow_id,
      subject_id: hit.subject_id,
      callback: callback_uri.to_s,
      preview: !persisted?
    }

    uri = URI.parse(BASE_URI)
    uri.query = query.to_query
    uri.to_s
  end
end
