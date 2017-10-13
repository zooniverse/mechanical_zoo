class MechanicalTurk
  include Singleton

  ENDPOINTS = {
    production: 'https://mturk-requester.us-east-1.amazonaws.com'.freeze,
    staging: 'https://mturk-requester-sandbox.us-east-1.amazonaws.com/'.freeze,
    test: 'https://mturk-requester-sandbox.us-east-1.amazonaws.com/'.freeze,
    development: 'https://mturk-requester-sandbox.us-east-1.amazonaws.com/'.freeze,
  }

  delegate :create_hit, to: :client

  private

  def client
    @client ||= Aws::MTurk::Client.new(endpoint: ENDPOINTS[Rails.env.to_sym],
                                       region: 'us-east-1',
                                       credentials: credentials)
  end

  def credentials
    @credentials ||= Aws::Credentials.new(
      Rails.application.secrets.aws_account_key,
      Rails.application.secrets.aws_secret_key
    )
  end
end
