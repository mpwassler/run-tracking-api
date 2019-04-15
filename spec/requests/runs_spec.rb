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
      run_a = create(:run, title: "run a")

      run_b = create(:run, title: "run b", path: "LINESTRING (-125 39, -114 34)")

      run_c = create(:run, title: "run c")

      run_d = create(:run, title: "run d")

      run_e = create(:run, title: "run e", path: "LINESTRING (-122.48379693756504 37.83381488486939, -122.48343236083984 37.83317989144141, -122.48332653015138 37.83270936637107, -122.48359819152832 37.832196363179625)")

      get "/api/v1/runs/#{run_a.id}/matched"

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)

      expect(json["runs"].count).to eq(3)
    end
  end
end
