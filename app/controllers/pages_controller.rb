class PagesController < ApplicationController
  def index
    @public_communities = Community.where(public: 2)
    #@public_communities.each do |pc|
    #  @pc = pc.communityName
    #end
  end
  
  def participate
  end
  
end
