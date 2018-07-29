class Images::Show < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  get "/images/:filename" do
    image = ImageQuery.new.filename(filename).first?
    if image.nil?
      flash.danger = "Image with filename: #{filename} not found"
      redirect to: Home::Index
    else
      ImageViewsForm.update!(image)
      render Images::ShowPage, image: image
    end
  end
end