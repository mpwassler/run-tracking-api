class V1::RunsController < ApplicationController
  def index
    render json: Run.all
  end

  def show
    render json: Run.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  def matched
    render json: Run.matched(params[:run_id])
  end

  private

    def run_params
      params.permit(
        geometry: [
          :coordinates
        ],
        properties: [
          :duration,
          :distance,
          :title
        ]
      )

    end

end
