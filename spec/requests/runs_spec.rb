require 'rails_helper'

RSpec.describe "Runs", type: :request do
  describe "GET /api/v1/runs" do
    it "Returns a list of runs" do

      run = create(:run)

      run = create(:run)

      get '/api/v1/runs'

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)

      expect(json['runs'].count).to eq(2)

    end
  end

  describe "GET /api/v1/runs/{:id}" do
    it "Returns run in geoJSON format" do

      run = create(:run)

      geojson = {
        "type" => "Feature",
        "geometry" => RGeo::GeoJSON.encode(run.path),
        "properties" => {
            "duration" => run.duration,
            "distance" => run.distance,
            "title" => run.title,
            "id" => run.id,
        }
      }.to_json

      get "/api/v1/runs/#{run.id}"

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)

      expect(json["run"].to_json).to eq(geojson)

    end

  end

  describe "GET /api/v1/runs/{:id}/matched" do
    it "can return a list of matched runs based on path" do
      run_a = build(:run)
      run_b = build(:run)
      run_c = build(:run)
      run_d = build(:run)

      run_a.title = "run a"
      run_b.title = "run b"
      run_c.title = "run c"
      run_d.title = "run d"

      run_b.path = "LINESTRING (-125 39, -114 34)"

      run_a.save
      run_b.save
      run_c.save
      run_d.save

      puts "==RUNS=="
      puts run_a.inspect
      puts run_b.inspect
      puts run_c.inspect
      puts "==RUNS=="

      get "/api/v1/runs/#{run_a.id}/matched"

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      # puts "===="
      pp json
      # puts "===="
      expect(1).to eq(2)


    end
  end
end
