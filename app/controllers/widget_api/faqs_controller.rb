class WidgetApi::FaqsController < ApplicationController
	include DecodeParams
	respond_to :json

	def index
		app = application
		@faqs = app.faqs.order(:question)
		render json: @faqs.to_json
	end

	def faq_params
		params.require(:faq).permit(:question, :answer )
	end

	private
  def application
    @application ||= Application.find_by(token: params[:appkey]) if params[:appkey]
  end
end
