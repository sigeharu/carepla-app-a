Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000', 'https://carepla-app-f.vercel.app'

    resource "*",
             headers: :any,
             expose: ["access-token", "expiry", "token-type", "uid", "client"],
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end
