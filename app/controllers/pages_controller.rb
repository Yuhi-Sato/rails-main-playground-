class PagesController < ApplicationController
  def home
    @featured_projects = Project.featured_first.limit(3)
    @recent_posts      = Post.published.recent.limit(3)
    @top_skills        = Skill.ordered.limit(8)
  end

  def about
    @skills_by_category = Skill.ordered.group_by(&:category)
  end

  def stats
    @posts_by_month = Post.published.group_by_month(:published_at, last: 12).count
    @skills_by_cat  = Skill.group(:category).count
    @published_count_via_fx = Post.published_count_via_fx
  end
end
