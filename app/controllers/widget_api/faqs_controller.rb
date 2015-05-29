class WidgetApi::FaqsController < ApplicationController
	respond_to :json

	def index
		@faqs = Faq.all.order(:question)
		render json: @faqs.to_json
	end

	def create
		@faq = Faq.new faq_params
		if @faq.save
			render json: {}, status: :created
		else
			render json: { errors: @faq.errors }, status: :unprocessable_entity
		end
	end

	def destroy
		@faq.destroy
	end


	def faq_params
		params.require(:faq).permit(:question, :answer )
	end
end
