class FaqsController < ApplicationController
	before_action :set_application

  def index
  	@faq = Faq.new
		@faqs = @application.faqs.order(:question)
  end

	def create
		@faq = @application.faqs.new faq_params
		if @faq.save
			#render json: {}, status: :created
			redirect_to application_faqs_path(@application.id), notice: 'Successfuly added' 
		else
			render json: { errors: @faq.errors }, status: :unprocessable_entity
		end
	end

#	def edit
#		@faq.edit
#		redirect_to edit_application_faq_path(@application.id)
#	end

	def destroy
		@faq.destroy
	end


	def faq_params
		params.require(:faq).
		  permit(
		  	:question, 
		  	:answer 
		  	)
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
