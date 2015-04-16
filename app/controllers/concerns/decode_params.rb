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
    matches.each do |match|
      params[match[1]] = match[2]
    end
  end
end
