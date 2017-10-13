class Assignment < ApplicationRecord
  def classify_url
    "/classify/callback?id=#{id}&classification_id=#{rand(10000000)}"
  end
end
