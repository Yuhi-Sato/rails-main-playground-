# Schked's schedule file. Tasks are declared using rufus-scheduler DSL.
# Run with: `bundle exec schked`.

every "1d" do
  # Nightly maintenance: purge discarded records older than 90 days.
  Rails.logger.info("[schked] nightly purge")
  Post.discarded.where(discarded_at: ..90.days.ago).find_each(&:destroy!)
  Project.discarded.where(discarded_at: ..90.days.ago).find_each(&:destroy!)
end
