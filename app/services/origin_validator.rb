class OriginValidator
  attr_accessor :app, :host

  def initialize(app: , host:)
    @app = app
    @host = host
  end

  class NonAcceptedOrigin < StandardError
    def message
      "not accepted origin, check your app's domain_url or the origin were your widget is installed"
    end
  end

  def is_valid?

    env_domain = Addressable::URI.parse(
      @host
    )

    app_domain = Addressable::URI.parse(@app.domain_url)

    # for now we will check for domain
    raise NonAcceptedOrigin if app_domain.domain != env_domain.domain
  end
end