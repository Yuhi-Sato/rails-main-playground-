class ProjectsController < ApplicationController
  def index
    @projects = authorized_scope(Project.all).featured_first
  end

  def show
    @project = Project.find(params[:id])
    authorize! @project
  end
end
