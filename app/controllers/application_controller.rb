# coding: utf-8
class ApplicationController < ActionController::Base
  
  FACEBOOK_EXTERNAL_HIT_UA = "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)"
  
  include Mobvious::Rails::Controller
  
  helper :application 
  protect_from_forgery

  before_filter :store_params
  before_filter :set_current_user
  before_filter :set_locale
  before_filter :set_p3p_headers
  before_filter :fetch_layout_variables
    
  def set_locale
    I18n.locale = :fr
  end
 
  def for_request_format(type, &block)
    yield block if @request_format == type.to_s
  end
  
  # we need this to handle specific behaviour to perform if we get hit by facebook
  # eg: exclude this hit from stats, flush object cache, display specific og:tags
  def request_comes_from_facebook_external_hit_ua?
    FACEBOOK_EXTERNAL_HIT_UA == request.env['HTTP_USER_AGENT']
  end

  # define the current user, whether it comes from warden auth or from any previous 
  # values stored in session[:user_id] that may be populated by any sso implementation
  def set_current_user
    @current_user = nil # current_user
  end
  
  # we need this for sidebar, sometimes.
  def fetch_layout_variables
  end
  
  def request_parameters
    params.except(:controller, :action, :authenticity_token, :_method)
  end

  
  # ie privacy related stuff 
  def set_p3p_headers
    headers['P3P'] = 'policyref="http://' + request.host + '/w3c/p3p.xml", CP= "CAO PSA OUR"'
  end
  
  # store where the request comes from so we can redirect the user after any POST action
  # mainly used to redirect the user to the requested resource after authentication
  def store_params
    session[:return_to] = params[:return_to] || request.get? ? request.fullpath : request.referer
  end
  
  def redirect_to_back_or(url, *args)
    options = args.extract_options!
    if anchor = options.delete(:anchor)
      flash[:anchor] = anchor.html_anchor_id
    end
    flash[:from] = "#{self.controller_path}##{self.action_name}"
    redirect_to(:back || session[:return_to] || url, options)
  end

  def redirect_to(options = {}, response_status = {})
    ::Rails.logger.error("Redirected by #{caller(1).first rescue "unknown"}")
    super(options, response_status)
  end
    
  def force_ssl
    return redirect_to protocol: "https" unless request.ssl?
  end
  
end