require 'httparty'
require 'json'

class Kele
  include HTTParty

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post("/sessions", body: { "email": email, "password": password })
    @auth_token = response ['auth_token']
    raise "Invalid Login Credentials" if response.code == 401
    puts @auth_token
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    @auth_token = response ['auth_token']
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    lets_meet = []
    mentor_id = get_me['current_enrollment']['mentor_id']
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @auth_token = response ['auth_token']
    if response.code != 200
      console.log(response.code)
    else
      JSON.parse(response.body).each do |avail|
        if avail['booked'].nil?
          lets_meet << avail
        end
      end
      lets_meet
    end
  end
end
