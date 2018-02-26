require 'sidekiq/testing'

RSpec.configure do |config|
  config.before(:each) do |example|
    Sidekiq::Worker.clear_all

    case example.metadata[:sidekiq]
    when :fake
      Sidekiq::Testing.fake!
    when :inline
      Sidekiq::Testing.inline!
    when :feature
      Sidekiq::Testing.inline!
    else
      Sidekiq::Testing.fake!
    end
  end
end
