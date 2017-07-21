module Util

  def self.appname
    Rails.application.class.parent
  end


end
