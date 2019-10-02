class JobsController < ApplicationController
    def index
        @jobs = Job.all
        render json: @jobs
    end

    def show
        find_job
        render json: @job
    end

    def new
        @job = Job.new
        render json: @job
    end

    def create
        @job = Job.create(job_params)
        render json: @job
    end

    def edit
        find_job
        render json: @job
    end
    
    def update
        find_job    
        @job.update(job_params)
        render json: @job
    end

    def destroy
        find_job
        @job.destroy
        render json: @job
    end

    private 

    def job_params
        params.require(:job).permit(:organization, :address, :title, :description, :user_id)
    end

    def find_job
        @job = Job.find(params[:id])
    end
end
