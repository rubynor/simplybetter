require 'base64'

class NoUserException   < StandardError;end
class NoAccessException < StandardError;end

module CreatorFinder

  def widget_user
    #TODO: OMA: We should always use the same user param, for simplicity. Convention :)
    decode_params if params["info"].present? && !(params[:user_email].present? || params[:email].present?)
    get_current_user(current_application, params[:user_email] || params[:email]) if params[:email] || params[:user_email]
  end


  def current_application
    decode_params if params["info"].present? && !(params["token"].present? || params["appkey"].present?)
    if params[:token] || params[:appkey]
      @current_application ||= Application.find_by!(token: params[:token] || params[:appkey])
    elsif session[:current_application]
      @current_application ||= Application.find(session[:current_application])
    end
  end

  def creator(application, creator_email)
    fail NoUserException, 'No email provided' unless creator_email
    if (a_customer = Customer.find_by(email: creator_email))
      if a_customer.widgets.include?(application) || a_customer.applications.include?(application)
        return a_customer
      end
      fail NoAccessException, 'The customer does not have access to this application'
    end

    if (user = User.find_by(email: creator_email))
      return user if user.widgets.include? application
      fail NoAccessException, 'The user does not have access to this application'
    end

    fail NoUserException, 'This user does not exist'
  end


  def get_current_user(application, user_email)
    fail ArgumentError, 'Missing application' unless application
    @current_user ||= creator(application, user_email)
  end

  def decode_params
    raise 'Nothing to decode' unless params["info"].present?
    matches = Base64.decode64(params["info"]).scan(/(\?|\&)([^=]+)\=([^&]+)/)
    matches.each do |match|
      params[match[1]] = match[2]
    end
  end

end
