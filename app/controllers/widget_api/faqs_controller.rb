class WidgetApi::FaqsController < ApplicationController
	respond_to :json

	def index
		@faqs = Faq.all.order(:question)
		render json: @faqs.to_json
	end

	def faq_params
		params.require(:faq).permit(:question, :answer )
	end
end
