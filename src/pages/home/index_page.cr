class Home::IndexPage < GuestLayout
  needs form : ImageForm
  needs images : ImageQuery

  def content
    div class: "homepage-container" do
      render_form(@form)
      
      gallery
    end
  end

  private def gallery
    h2 "Image Gallery"

    ul class: "image-gallery" do
      @images.map do |image|
        li class: "image", flow_id: "image-#{image.id}" do
          div class: "picture", style: "background-image: url(#{image.path});" do
            div "Views: #{image.views}", class: "views"
          end

          link to: Images::Delete.with(image.id), flow_id: "delete-image-#{image.id}" do
            img src: asset("images/x.png")
          end

          div image.url, class: "image-url",  flow_id: "image-url-#{image.id}"
        end
      end
    end
  end

  private def render_form(f)
    form_for Images::Create, enctype: "multipart/form-data" do
      text_input f.image, type: "file", flow_id: "file-input"      

      ul do
        f.image.errors.each do |err|
          li "Image #{err}", class: "error"
        end
      end

      submit "Upload Image", flow_id: "upload-image"
    end
  end
end
