class Applicant < ApplicationRecord
  validates_presence_of :email, :github, :application
  validates_uniqueness_of :email, :github
end
