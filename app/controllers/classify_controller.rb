class ClassifyController < ApplicationController
  before_action :skip_authorization

  def start
    if params[:assignmentId] == "ASSIGNMENT_ID_NOT_AVAILABLE"
      @assignment = Assignment.new(hit_id: params[:hitId])

      redirect_to @assignment.classify_url("")
    else
      @assignment = Assignment \
                      .create_with(hit_id: params[:hitId],
                                   turk_submit_to: params[:turkSubmitTo],
                                   worker_id: params[:workerId])
                      .find_or_create_by(id: params[:assignmentId])

      redirect_to @assignment.classify_url(callback_classify_url(id: @assignment.id))
    end

  end

  def callback
    @assignment = Assignment.find(params[:id])

    # TODO: Verify that classification is OK for this assignment
    @assignment.update! classification_id: params[:classification_id]
    ProcessAssignment.new(@assignment).call
  end

  private

  def authenticated?
    true
  end
end
