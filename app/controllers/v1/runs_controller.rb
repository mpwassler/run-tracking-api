class V1::RunsController < ApplicationController
  def index
    render json: Run.all
  end

  def show
    render json: Run.find(params[:id])
  end

  def create
    feature = RGeo::GeoJSON.decode(params.to_json)
    run = Run.new
    run.path = feature.geometry.as_text
    run.title = feature['title']
    run.duration = feature['duration']
    run.distance = feature['distance']
    if run.save
      render :json => run, :status => 201
    end
  end

  def update
    run = Run.find params[:id]
    run.title = params[:title]
    if run.save
      render :json => run, :status => 200
    end
  end

  def destroy
    Run.destroy params[:id]
    render :json => {}, :status => 200
  end

  def matched
    render json: Run.matched(params[:run_id])
  end



end

