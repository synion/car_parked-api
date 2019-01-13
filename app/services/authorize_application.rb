class AuthorizeApplication
  class Error < StandardError ; end

  def self.call(headers)
    new(headers).call
  end

  def initialize(headers)
    @headers = headers
  end

  def call
    raise Error, "Application not recognized" unless header_has_authorize_key
  end

  private

  attr_reader :headers

  def header_has_authorize_key
    ENV.fetch('AUTHORIZE_APPLICATION').split('|').include?(headers['HTTP_AUTHORIZATION'])
  end
end
