class Api::UserDataController < ApplicationController
    skip_before_action :verify_authenticity_token
    def test
        respond_to do |format|
            format.json{render json: { solution: "not found"}}
        end
    end

    def create
        first_name = params[:first_name]
        last_name = params[:last_name]
        user = MongoUserData.new(:first_name=>first_name,:last_name=>last_name)
        respond_to do |format|
            if user.save
              format.json{render json: { status: user}}
            else
              format.json{render json: {errors: user.errors}}
            end
        end
    end

    def createmongo
        first_name = params[:first_name]
        last_name = params[:last_name]
        user = MongoWowgram.new(:description=>first_name,:body=>last_name ,:user_id =>1)
        respond_to do |format|
            if user.save
              format.json{render json: { status: user}}
            else
              format.json{render json: {errors: user.errors}}
            end
        end
    end
end