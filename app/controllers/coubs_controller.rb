class CoubsController < ApplicationController
  def index
  end

  def create
    @coub = current_user.coubs.create(coub_params)
    @coub.generate_and_upload_video

    redirect_to @coub.url
  end

  private

  def coub_params
    params.require(:coub).permit(
      :text1, :text2, :text3, :visibility_type, :tags
    )
  end
end
