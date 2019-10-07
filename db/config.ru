require_relative './config/environment'

require './confi/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending.'
end

use Rack::MethodOverride
run ApplicationController
