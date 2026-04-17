class PagesController < ApplicationController
  def home
    @featured_projects = Project.featured_first.limit(3)
    @recent_posts      = Post.published.recent.limit(3)
    @top_skills        = Skill.ordered.limit(8)
  end

  def about
    @skills_by_category = Skill.ordered.group_by(&:category)
  end
end
