class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:success] = 'Company was successfully created.'
      redirect_to root_path
    else
      flash[:danger] = 'There was a problem creating the Company.'
      render action: "new"
    end
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :email, :password, :password_confirmation)
    end