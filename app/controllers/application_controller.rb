class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :set_last_seen_at, if: proc { logged_in? }
  #
  # private
  # def set_last_seen_at
  #   current_user.update_column(:last_seen_at, Time.now)
  # end

end
