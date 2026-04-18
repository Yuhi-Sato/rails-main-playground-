class ApplicationService
  include Dry::Monads::Result::Mixin

  def self.call(...)
    new.call(...)
  end
end
