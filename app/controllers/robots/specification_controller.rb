class Robots::SpecificationController < ApplicationController
  layout false

  def allow_access_with_sitemap
    @current_site_name = request.protocol + request.host_with_port
    render 'allow_with_sitemap', formats: :txt
  end

  attr_reader :current_site_name
  helper_method :current_site_name
end
