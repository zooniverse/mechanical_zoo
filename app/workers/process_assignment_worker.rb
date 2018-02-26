class ProcessAssignmentWorker
  include Sidekiq::Worker

  def perform(assignment_id)
    Assignment.transaction do
      assignment = Assignment.find(assignment_id)
      ProcessAssignment.new(assignment).call
    end
  end
end
