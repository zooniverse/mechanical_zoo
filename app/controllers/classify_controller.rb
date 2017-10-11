class ClassifyController < ApplicationController
  def start
  end

  def callback
    @classification = Classification.new(id: params[:classification_id])
  end
end
