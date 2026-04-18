class Post::Publisher < ActiveRecord::AssociatedObject
  # Called directly by Post#publish (the state-machine event).
  # active_record-associated_object + active_job-performs let us call
  # `post.publish_later` to push this into Sidekiq/SolidQueue.
  def call(**)
    announce!
  end

  private

  def announce!
    ContactNotifier.notify(
      name:    "Publisher Bot",
      email:   "no-reply@yuhi.dev",
      message: "New post published: #{post.title} (#{post.slug})"
    ).notify_later
  end
end
