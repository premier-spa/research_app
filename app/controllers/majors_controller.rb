class MajorsController < ApplicationController
    def index
        majors = params[:course_id].nil? ? Major.all \
            : Major.where(course_id: params[:course_id])
        render :json => majors
    end
end
