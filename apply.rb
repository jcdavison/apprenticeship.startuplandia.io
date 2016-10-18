require 'faraday'
require 'json'

# [:github, :email, :linkedin :personal_site, questions: [ :fibonacci, :user_auth_diagram, :http_diagram_1, :http_diagram_2 ]]

conn = Faraday.new(:url => 'http://apprenticeship.startuplandia.io/api/applicants')
application_body =  {
  application: {
    github: 'startuplandia',
    email: 'jd@startuplandia.io',
    linkedin: 'https://www.linkedin.com/in/jcdavison',
    personal_site: 'http://startuplandia.io',
    questions: {
      fibonacci: 'https://gist.github.com/jcdavison/2146f7095cd0c2a50dd1678ee11c8f2c',
      user_auth_diagram: 'https://dl.dropboxusercontent.com/u/12834645/user_auth_diagram.jpg',
      http_diagram_1: 'https://dl.dropboxusercontent.com/u/12834645/http_diagram_1.jpg',
      http_diagram_2: 'https://dl.dropboxusercontent.com/u/12834645/http_diagram_2.jpg'
    } 
  }
}.to_json


response = conn.post do |req|
  req.headers['Content-Type'] = 'application/json'
  req.body = application_body
end

p JSON.parse response.body
