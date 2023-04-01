# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Load seeds on bootup
unless Post.any?
  puts "Seeding database..."
  Rails.application.load_seed
end
