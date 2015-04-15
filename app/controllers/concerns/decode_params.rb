require 'base64'
module DecodeParams
  extend ActiveSupport::Concern

  included do
    before_action do
      if params["info"].present?
        decode_params
      end
    end
  end

  def decode_params
    matches = Base64.decode64(params["info"]).scan(/(\?|\&)([^=]+)\=([^&]+)/)
    params[matches[0][1]] = matches[0][2]
    params[matches[1][1]] = matches[1][2]
    params[matches[2][1]] = matches[2][2]
  end
end
