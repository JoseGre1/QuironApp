class StudentsController < ApplicationController
  #before_action :authenticate
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def create
    @student = Student.new(student_params)
    if @student.save
      render json: { student: @student, success: true }
    else
      render json: { student: @student.errors.messages, success: false}
    end
  end

  def show
    if params[:id]
      #Specefic student
      @students = Student.find_by(id: params[:id])
    elsif params[:institution_id]
      #All Students from an institution
      @students = Institution.find_by(id: params[:institution_id]).students
    elsif params[:number]
      #Best Students
      @students = Student.order_by(global_score: :desc).first(params[:number].to_i)
    elsif params[:number] && params[:institution_id]
      #Best Students from an institution
      @students = Institution.find_by(id: params[:institution_id]).students.order_by(global_score: :desc).first(params[:number].to_i)
    else
      #All Students
      @students = Student.all
    end
    render json: { students: @students }

  end

  def update
    @student = Student.find_by(id: params[:id])
    if @student.update_attributes(student_params)
      render json: { student: @student, success: true}
    else
      render json: { student: @student.errors.messages, success: false }
    end
  end

  def destroy
    @student = Student.find_by(id: params[:id])
    if @student.destroy
      render json: { student: @student, success: true }
    else
      render json: { student: @student.errors.messages, success: false }
    end
  end

  private
    #Extract user params from POST request in a safe way
    def student_params
      params.require(:student).permit(:name, :email, :icfes_score, :school_score, :extra_score, :age, :institution_id, :gender)
    end

    def authenticate
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == 'admin' && password == 'admin1234'
      end
    end
end
