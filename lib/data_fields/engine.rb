module DataFields
  class Engine < ::Rails::Engine
    isolate_namespace DataFields

    config.generators do |g|
      g.test_framework :rspec
      g.assets false
      g.helper false
    end

    config.autoload_paths << root.join("app/models").to_s
  end
end
