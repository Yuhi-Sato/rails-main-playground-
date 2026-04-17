class ProjectCardComponent < ApplicationComponent
  extend Dry::Initializer

  option :project

  def tech_chips
    project.tech_list
  end
end
