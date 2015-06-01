class FaqsController < ApplicationController
	before_action :set_application

  def index
		@faqs = @application.faqs.order(:question)
  end

	def create
		@faq = @application.faqs.new faq_params
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

	def set_application
	  @application ||= current_customer.applications.find(params[:application_id]) if params[:application_id]
	rescue
	  respond_to do |format|
	    format.html do
	      flash[:error] =  "You don't seem to have access to this"
	    	redirect_to applications_path
	  	end
	  	format.json { render json: { message: 'Not authorized' }, status: :unauthorized}
		end

	end

end
