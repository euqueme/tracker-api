class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show update destroy]
  before_action :check_admin, only: %i[create update destroy]
  skip_before_action :authorize_request, only: %i[index show]

  # GET /exercises
  def index
    @exercises = Exercise.all
    json_response(@exercises)
  end

  # POST /exercises
  def create
    @exercise = current_user.exercises.create!(exercise_params)
    json_response(@exercise, :created)
  end

  # GET /exercises/:id
  def show
    json_response(@exercise)
  end

  # PUT /exercises/:id
  def update
    @exercise.update(exercise_params)
    head :no_content
  end

  # DELETE /exercises/:id
  def destroy
    @exercise.destroy
    head :no_content
  end

  private

  def exercise_params
    # whitelist params
    params.permit(:name)
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def check_admin
    raise(ExceptionHandler::AuthenticationError, Message.notallowed) unless current_user.admin
  end
end
