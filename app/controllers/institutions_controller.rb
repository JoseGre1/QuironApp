class InstitutionsController < ApplicationController
    #before_action :authenticate
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

    def create
      @institution = Institution.new(institution_params)
      @institution.superuser = Superuser.find_by(name: "minedu")
      if @institution.save
        render json: { institution: @institution, success: true}
      else
        render json: { institution: @institution.errors.messages, success: false}
      end
    end

    def show
      if params[:id]
        #Specefic Institution
        @institutions = Institution.select(Institution.column_names - ["password_digest"]).find_by(id: params[:id].to_i)
      else
        #All institutions
        @institutions = Institution.all.select(Institution.column_names - ["password_digest"])
      end
      render json: { institutions: @institutions }
    end

    def update
      @institution = Institution.find_by(id: params[:id])
      if @institution.update_attributes(institution_params)
        render json: { institution: @institution, success: true }
      else
        render json: { institution: @institution.errors.messages, success: false }
      end
    end

    def destroy
      @institution = Institution.find_by(id: params[:id])
      if @institution.destroy
        render json: { institution: @institution, success: true }
      else
        render json: { institution: @institution.errors.messages, success: false }
      end
    end

    private
      #Extract user params from POST request in a safe way
      def institution_params
        params.require(:institution).permit(:name, :email, :city, :password, :password_confirmation)
      end
      def authenticate
        authenticate_or_request_with_http_basic('Administration') do |username, password|
          username == 'admin' && password == 'admin1234'
        end
      end
end
