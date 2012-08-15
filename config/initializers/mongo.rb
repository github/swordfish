url  = ENV["GH_MONGODB_URL"] || ENV["MONGODB_URI"] || ENV["MONGOHQ_URL"]
conn = Mongo::Connection.from_uri(url || "mongodb://localhost:27017")

Swordfish::Application.config.mongo = conn.db("vault-#{Rails.env}")
