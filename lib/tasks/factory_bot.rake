# frozen_string_literal: true

# lib/tasks/factory_bot.rake
namespace :factory_bot do
  desc 'Factories linting'
  task lint: :environment do
    if Rails.env.test?
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      raise if $CHILD_STATUS.exitstatus.nonzero?
    end
  end
end
