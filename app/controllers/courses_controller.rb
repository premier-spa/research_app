class CoursesController < ApplicationController
    def index
        courses = params[:university_id].nil? ? Course.all \
            : Course.where(university_id: params[:university_id])
        render :json => courses
    end
end
