module Roadmap
  def get_roadmap(id)
    response = self.class.get("/roadmaps/#{id}", headers: { "authorization" => @auth_token })
    @user_map = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    @user_checkpoints = JSON.parse(response.body)
  end
end
