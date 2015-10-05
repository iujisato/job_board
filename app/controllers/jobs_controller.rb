class JobsController < ApplicationController
  before_filter :authorize_company, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy]


def new_comment(job, comment)
  @job = job
  @comment = comment
  @company = job.company

  mail to: @company.email, subject: "New comment received"
end

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.most_recent.includes(:company).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def premium
    @jobs = Job.where(premium: true).most_recent.includes(:company).paginate(page: params[:page], per_page: 10)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
     @job = Job.find_by_slug(params[:id])
     @comments = @job.comments.order('id desc')

     respond_to do |format|
     format.html # show.html.erb
     format.json { render json: @job }
     end
  end

  # GET /jobs/new
  def new
    @job = current_company.jobs.build
  end

  # GET /jobs/1/edit
  def edit
    @job = current_company.jobs.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = current_company.jobs.build(job_params)

    respond_to do |format|
      if @job.save
        flash[:success] = 'Job was successfully created.'
        format.html { redirect_to @job}
        format.json { render :show, status: :created, location: @job }
      else
        flash[:danger] = 'There was a problem creating the Job.'
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @job = current_company.jobs.find(params[:id])
    respond_to do |format|
      if @job.update(job_params)
        flash[:success] = 'Job was successfully updated.'
        format.html { redirect_to @job}
        format.json { render :show, status: :ok, location: @job }
      else
        flash[:danger] = 'There was a problem updating the Job.'
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = current_company.jobs.find(params[:id])
    @job.destroy
    respond_to do |format|
      flash[:success] = 'Job was successfully deleted.'
      format.html { redirect_to jobs_url}
      format.json { head :no_content }
    end
  end

  private
    def authorize_company
      unless current_company
        redirect_to root_path
        flash[:danger] = 'You need to login to continue.'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :premium, :comment)
    end
end
