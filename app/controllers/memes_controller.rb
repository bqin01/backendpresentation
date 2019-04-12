class MemesController < ApplicationController
  def new
    # Uses GET to display the HTML for the new meme.
    image = Image.find_by_id(params[:image_id]) || Image.order("RANDOM()").first
    @meme = Meme.new(image: image)
  end

  def create
    # Uses POST to create the new meme.
    fabricator = MemeFabricator.new(meme_params)
    @meme = fabricator.meme
    fabricator.call
    flash[:notice] = "Meme successfully created"
    redirect_to @meme
  rescue
    render :new
  end

  def show
    # Uses GET to display a photo.
    @meme = Meme.find(params[:id])
  end

  private

  def meme_params
    @meme_params ||= params.require(:meme)
                           .permit(:top, :bottom, :image_id)
                           .to_hash
                           .symbolize_keys
  end

  # If there was say, a def delete here, we would be able to use DELETE to remove a meme.
end
