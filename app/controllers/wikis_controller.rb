class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(user: current_user)
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki is now posted!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki post...please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki posting is now updated!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the wiki...please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki...please try again."
      render :show
    end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user)
  end

  # def authorize_user
  #   unless current_user?
  #     flash[:alert] = "You must be a registered user to do that!"
  #     redirect_to wikis_path
  #   end
  # end
end




