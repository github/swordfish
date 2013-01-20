#uri      = URI.parse ENV["GH_MONGODB_URL"] || ENV["MONGODB_URI"] || ENV["MONGOHQ_URL"] || ENV["MONGOLAB_URL"]
#conn     = Mongo::Connection.from_uri(uri.to_s)
#database = uri.path.sub('/', '')
#database = "swordfish-#{Rails.env}" if database.blank?
#db       = conn.db(database)
#
#Swordfish::Application.config.mongo = db
