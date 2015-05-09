class WikisController < ApplicationController
  def index
    @wikis = Wiki.all.order(:title)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = @user

    authorize @wiki

    if @wiki.save
      redirect_to @wiki
    else
      flash[:error] = 'There was an error saving the wiki. Please try again.'
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = 'Wiki was updated.'
      redirect_to @wiki
    else
      flash[:error] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = 'Wiki was deleted successfully.'
      redirect_to wikis_path
    else
      flash[:error] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :wiki_private)
  end
end
