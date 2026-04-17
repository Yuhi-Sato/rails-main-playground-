class SkillBadgeComponent < ApplicationComponent
  extend Dry::Initializer

  option :skill

  CATEGORY_COLORS = {
    "language"  => "bg-rose-100 text-rose-800",
    "framework" => "bg-indigo-100 text-indigo-800",
    "database"  => "bg-emerald-100 text-emerald-800",
    "devops"    => "bg-amber-100 text-amber-800",
    "tool"      => "bg-sky-100 text-sky-800",
    "other"     => "bg-slate-100 text-slate-800"
  }.freeze

  def color_class
    CATEGORY_COLORS.fetch(skill.category, CATEGORY_COLORS["other"])
  end

  def filled_dots
    skill.level.to_i.clamp(0, 5)
  end

  def empty_dots
    5 - filled_dots
  end
end
