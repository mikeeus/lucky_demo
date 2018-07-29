class Images::ShowPage < GuestLayout
  include Layout::HeaderComponent

  needs image : Image

  def content
    render_header

    div style: "text-align: center;" do
      h1 @image.filename
      img src: @image.path, style: "max-width: 100%; height: auto;"
    end
  end
end
