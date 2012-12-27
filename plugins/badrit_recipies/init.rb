Rails.configuration.to_prepare do
  unless CustomValue.included_modules.include? BadritRecipies::CustomValuePatch
    CustomValue.send :include, BadritRecipies::CustomValuePatch
  end
end

Redmine::Plugin.register :badrit_recipies do
  name 'Badrit Recipies plugin'
  author 'Mahmoud Khaled'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
