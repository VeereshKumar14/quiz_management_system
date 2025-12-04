Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'   # You can restrict later to your React URL

    resource '*',
      headers: :any,
      expose: ['Authorization'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
