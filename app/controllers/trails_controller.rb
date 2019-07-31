require "open-uri"

class TrailsController < ApplicationController
    
    
    skip_before_action :authorized
    
    def trails_search
        lat = params[:lat].sub('!', '.')
        lon = params[:lon].sub('!', '.')
        url = "https://www.hikingproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxResults=#{params[:max_results]}"
        api_key = "200524977-84faacbb836e7961310518eab8e364d5"
        trails = JSON.parse(open(url + api_key).read)["trails"][0..39]
        sorted_trails = trails.sort_by{|t| t['stars']}.reverse

        render json: sorted_trails, status: :ok
    end

    def show
        begin @trail = Trail.find(params[:id])
            render json: @trail
        rescue
            render json: {status: "error", code: 404, message: "Trail doesn't exist!"}
        end
    end

    def index
        @trails = Trail.all 
        render json: @trails
    end
    
end
