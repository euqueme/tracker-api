class MeasurementsController < ApplicationController
    before_action :set_exercise
    before_action :set_exercise_measurement, only: [:show, :update, :destroy]
    before_action :check_current_user
  
    # GET /exercises/:exercise_id/measurements
    def index
      json_response(@exercise.measurements)
    end
  
    # GET /exercises/:exercise_id/measurements/:id
    def show
      json_response(@measurement)
    end
  
    # POST /exercises/:exercise_id/measurements
    def create
      @exercise.measurements.create!(measurement_params)
      json_response(@exercise.measurements.last, :created)
    end
  
    # PUT /exercises/:exercise_id/measurements/:id
    def update
      @measurement.update(measurement_params)
      head :no_content
    end
  
    # DELETE /exercises/:exercise_id/measurements/:id
    def destroy
      @measurement.destroy
      head :no_content
    end
  
    private
  
    def measurement_params
      params.permit(:description, :amount, :exercise_id, :user_id)
    end
  
    def set_exercise
      @exercise = Exercise.find(params[:exercise_id])
    end
  
    def set_exercise_measurement
      @measurement = @exercise.measurements.find_by!(id: params[:id]) if @exercise
    end

    def check_current_user
      raise(ExceptionHandler::AuthenticationError, Message.notyou) unless current_user.id.to_s == params[:user_id]
    end
end
