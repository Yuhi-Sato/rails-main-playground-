require "rails_helper"

RSpec.describe "SiteFeatures (feature_toggles)" do
  def with_env(hash)
    original = hash.to_h { |k, _| [k, ENV[k]] }
    hash.each { |k, v| ENV[k] = v }
    yield
  ensure
    original.each { |k, v| ENV[k] = v }
  end

  it "is disabled by default" do
    with_env("YUHI_DARK_MODE" => nil, "YUHI_HERO_IMAGE" => nil) do
      expect(SiteFeatures.enabled?(:dark_mode)).to be(false)
      expect(SiteFeatures.enabled?(:hero_image)).to be(false)
    end
  end

  it "responds to the env toggle" do
    with_env("YUHI_DARK_MODE" => "1") do
      expect(SiteFeatures.enabled?(:dark_mode)).to be(true)
    end
  end

  it "enumerates all known toggles" do
    expect(SiteFeatures.names).to include(:dark_mode, :hero_image)
  end
end
