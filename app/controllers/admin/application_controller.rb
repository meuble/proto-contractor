class Admin::ApplicationController < ApplicationController
  
  layout "application"
  
#  before_filter :require_login
#  before_filter :ensure_admin_role
  before_filter :assign_view_path
  before_filter :force_ssl, :if => Proc.new { Rails.env.production? }
  before_filter :set_layout_vars
  
  def set_layout_vars
    @admin = true
  end
  
  def assign_view_path
    prepend_view_path "#{::Rails.root}/app/views/admin"
  end
  
  # TODO: implement this!
  def ensure_admin_role
    unless @current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js   { render :json => {:message => "unauthorized"}, :status => 401 }
      end
    end
  end
  
end
