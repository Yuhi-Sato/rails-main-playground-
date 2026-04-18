class ProjectCardComponentPreview < Lookbook::Preview
  def default
    project = Project.new(
      title: "Demo project",
      description: "An example project card rendered by Lookbook.",
      tech_stack: "Ruby, Rails, PostgreSQL, Hotwire",
      url: "https://example.com",
      github_url: "https://github.com/yuhi/demo",
      featured: true
    )
    render(ProjectCardComponent.new(project: project))
  end
end
