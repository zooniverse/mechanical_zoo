class ClassifyController < ApplicationController
  def start
    if params[:assignmentId] == "ASSIGNMENT_ID_NOT_AVAILABLE"
      @assignment = Assignment.new
    else
      @assignment = Assignment \
                      .create_with(hit_id: params[:hitId],
                                   turk_submit_to: params[:turkSubmitTo],
                                   worker_id: params[:workerId])
                      .find_or_create_by(id: params[:assignmentId])
    end
  end

  def callback
    @assignment = Assignment.find(params[:id])
  end
end
