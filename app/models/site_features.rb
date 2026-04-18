SiteFeatures = FeatureToggles.build do
  env "YUHI"

  feature(:dark_mode) { ENV["YUHI_DARK_MODE"] == "1" }
  feature(:hero_image) { ENV["YUHI_HERO_IMAGE"] == "1" }
end
