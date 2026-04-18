require "dry/effects"

# Example of dry-effects usage: a Reader effect for the current actor
# that service objects can pull from without threading it through every
# method call. Handle with `Dry::Effects::Handler.Reader(:actor)`.
class AuditTrail
  include Dry::Effects.Reader(:actor, default: "system")

  def record(event)
    Rails.logger.info("[audit] actor=#{actor} event=#{event}")
  end
end
