class ProjectsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @projects = credential.fetch_accessible_projects
  end
end
