class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @users = params[:user_ids]
    @wiki = Wiki.find(params[:wiki_id])
    @users.each do |user| 
      @wiki_collaboration = @wiki.collaborations.new(user_id: user)
      @wiki_collaboration.save
    end
    flash[:success] = "Collaborator added."
    redirect_to @wiki
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])

    @collaboration.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

end
