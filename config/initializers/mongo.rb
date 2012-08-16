uri  = URI.parse ENV["GH_MONGODB_URL"] || ENV["MONGODB_URI"] || ENV["MONGOHQ_URL"]
conn = Mongo::Connection.from_uri(uri.to_s)
db   = conn.db(uri.path.blank? ? "swordfish-#{Rails.env}" : uri.path.sub('/', ''))

Swordfish::Application.config.mongo = db
