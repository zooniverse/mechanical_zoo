class ImportWorkflowSubjects
  def initialize(credential, workflow)
    @credential = credential
    @workflow = workflow
  end

  def call
    @credential.client.subjects(workflow_id: @workflow.id).each do |panoptes_subject|
      WorkflowSubject.find_or_create_by! workflow: @workflow,
                                         subject_id: panoptes_subject["id"]
    end
  end
end
