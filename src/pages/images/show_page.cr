class Images::ShowPage < GuestLayout
  needs image : Image

  def content
    div style: "text-align: center;" do
      h1 @image.filename
      h2 "Views: #{@image.views}"
      img src: @image.path, style: "max-width: 100%; height: auto;"
    end
  end
end