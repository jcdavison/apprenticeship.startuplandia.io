class Api::ApplicantsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    applicant = build_waffle snag_params
    if applicant.save
      render json: serve_waffle(applicant)
    else
      head :bad_request
    end
  end

  private

  def build_waffle waffle_details
    record = Applicant.where(email: waffle_details[:email], github: waffle_details[:github])
      .first_or_initialize do |record|
        record.application = {questions: waffle_details[:questions]}
      end
    record.update_attributes(linkedin: waffle_details[:linkedin], personal_site)
    record
  end

  def snag_params
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
      source: 'jd+apprenticeship@startuplandia.io',
      updated_at: applicant.updated_at.to_s
    }
  end
end
