class Api::ApplicantsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    applicant = process_waffle hashify_params
    if applicant.save
      render json: serve_waffle(applicant)
    else
      head :bad_request
    end
  end

  private

  def process_waffle details
    update_waffle(build_waffle(details), details)
  end

  def build_waffle details
    Applicant.where(email: details[:email], github: details[:github]).first_or_initialize
  end

  def update_waffle waffle, details
    application = details[:questions].symbolize_keys
    waffle.application = application 
    waffle.linkedin = details[:linkedin]
    waffle.personal_site = details[:personal_site]
    waffle
  end

  def hashify_params
    params.require(:application).permit(application_params).to_h
  end

  def bundle_questions details
    details.each_with_object({}) do |obj, (k, v)|
      if k.to_s.match /question/
        obj[k] = v
      end
    end
  end

  def application_params
    [:github, :email, :linkedin, :personal_site, questions: [ :fibonacci, :user_auth_diagram, :http_diagram_1, :http_diagram_2 ]]
  end

  def serve_waffle(applicant)
    {
      thanks: "Hi #{applicant.github}, thank you for your application.",
      next_steps: "Expect to hear back from me rain or shine within 7 business days :)",
      source: "#{applicant.email}",
      updated_at: applicant.updated_at.to_s,
      applicants_to_date: Applicant.count
    }
  end
end
