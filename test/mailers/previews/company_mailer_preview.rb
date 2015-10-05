# Preview all emails at http://localhost:3000/rails/mailers/company_mailer
class CompanyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/company_mailer/new_comment
  def new_comment
    CompanyMailer.new_comment
  end

end
