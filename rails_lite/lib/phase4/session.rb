require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      our_cookie = nil
      req.cookies.each do |cookie|
        if cookie.name == '_rails_lite_app'
          our_cookie = cookie
          break
        end
      end
      @contents = (our_cookie.nil? ? {} : JSON.parse(our_cookie.value) )
    end

    def [](key)
      @contents[key]
    end

    def []=(key, val)
      @contents[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies <<
        WEBrick::Cookie.new('_rails_lite_app', @contents.to_json)
    end
  end
end
