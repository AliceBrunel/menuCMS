require_relative './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending.'
end

use Rack::MethodOverride
use UsersController
use MealsController
use MenusController
run ApplicationController
