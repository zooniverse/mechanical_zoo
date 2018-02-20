class ProcessAssignment
  attr_reader :assignment

  def initialize(assignment)
    @assignment = assignment
  end

  def call
    # TODO: Check that the classification exists and is sensible
    accept
  end

  def accept
    mechanical_turk.approve_assignment(assignment_id: assignment.id)
    assignment.touch(:approved_at)
  end

  def reject
    # TODO
    assignment.touch(:rejected_at)
  end

  private

  def mechanical_turk
    MechanicalTurk.instance
  end

end
