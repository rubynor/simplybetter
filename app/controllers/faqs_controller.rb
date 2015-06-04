class FaqsController < ApplicationController
	before_action :set_application

  def index
  	@faq = Faq.new
		@faqs = @application.faqs.order(:question)
  end

	def create
		@faq = @application.faqs.new faq_params
		if @faq.save
			redirect_to application_faqs_path(@application.id), notice: 'Successfully added' 
		else
			render json: { errors: @faq.errors }, status: :unprocessable_entity
		end
	end

	def edit
		@faq = Faq.find(params[:id])			
	end

	def update
		redirect_to application_faqs_path(@application.id) and return if params[:cancel]
		@faq = Faq.find(params[:id])
		if @faq.update_attributes(faq_params)
		  redirect_to application_faqs_path(@application.id), notice: 'Successfully updated'
		else
			render 'edit'
		end
	end

	def destroy
		@faq = Faq.find(params[:id])
		if @faq.destroy
			redirect_to application_faqs_path(@application.id), notice: 'Successfully removed'
	  else
			render json: { errors: @faq.errors }, status: :unprocessable_entity
		end
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
