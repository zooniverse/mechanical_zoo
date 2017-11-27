class WorkflowsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @workflows = credential.fetch_accessible_workflows(project.id)
  end

  private

  def project
    Project.find(params["project_id"])
  end
end
