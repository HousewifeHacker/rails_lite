require_relative '../phase3/controller_base'
require_relative './session'


#initialize(req, res) from Phase 2
#store_session(res) from session Phase 4
module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super
      session.store_session(@res)
    end

    def render_content(content, type)
      super
      session.store_session(@res)
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(@req)
    end
  end
end