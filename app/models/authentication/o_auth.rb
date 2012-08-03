module Authentication
  class OAuth
    def initialize(auth)
      @auth = auth
    end

    def user
      @user ||= find || create
    end

    def find
      conditions = {
        'credentials.provider' => @auth.provider,
        'credentials.uid'      => @auth.uid
      }

      User.first(conditions).tap do |user|
        if user
          credential = user.credentials.detect do |c|
            c['provider'] == @auth.provider && c['uid'] == @auth.uid
          end
          credential.update @auth
          user.save!
        end
      end
    end

    def create
      User.new.tap do |user|
        user.credentials << @auth
        user.save!
      end
    end
  end
end