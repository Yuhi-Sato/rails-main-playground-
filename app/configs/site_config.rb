class SiteConfig < Anyway::Config
  config_name :site

  attr_config owner_name:     "Yuhi",
              owner_handle:   "yuhi",
              owner_role:     "Software Engineer",
              owner_location: "Tokyo, Japan",
              owner_email:    "hello@example.com",
              github_url:     "",
              twitter_url:    "",
              linkedin_url:   "",
              bio:            ""
end
