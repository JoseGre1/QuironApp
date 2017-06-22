class SessionsController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def create
    if params[:session][:user_type] == "Ministerio"
      user = Superuser.find_by(email: params[:session][:email].downcase)
    elsif params[:session][:user_type] == "Institución"
      user = Institution.find_by(email: params[:session][:email].downcase)
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      user.password_digest = ""
      render json: { user: user , success: true }
    else
      render json: { user: "", success: false }
    end
  end

  def destroy
    log_out
    render json: { success: true}
  end
end
