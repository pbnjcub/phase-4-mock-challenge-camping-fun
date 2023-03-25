class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = find_camper
        render json: camper, include: :activities
    end

    def create
        camper = Camper.new(camper_params)
        if camper.save
          render json: camper, status: :created
        else
          render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

end
