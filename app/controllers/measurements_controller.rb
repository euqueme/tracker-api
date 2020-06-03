class MeasurementsController < ApplicationController
    before_action :set_user
    before_action :set_user_measurement, only: [:show, :update, :destroy]
    before_action :check_current_user, only: [:create, :update, :destroy]
  
    # GET /users/:user_id/measurements
    def index
      json_response(@user.measurements)
    end
  
    # GET /users/:user_id/measurements/:id
    def show
      json_response(@measurement)
    end
  
    # POST /users/:user_id/measurements
    def create
      @user.measurements.create!(measurement_params)
      json_response(@user.measurements.last, :created)
    end
  
    # PUT /users/:user_id/measurements/:id
    def update
      @measurement.update(measurement_params)
      head :no_content
    end
  
    # DELETE /users/:user_id/measurements/:id
    def destroy
      @measurement.destroy
      head :no_content
    end
  
    private
  
    def measurement_params
      params.permit(:description, :amount, :exercise_id, :user_id)
    end
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_user_measurement
      @measurement = @user.measurements.find_by!(id: params[:id]) if @user
    end

    def check_current_user
      raise(ExceptionHandler::AuthenticationError, Message.notyou) unless current_user.id.to_s == params[:user_id]
    end
end
