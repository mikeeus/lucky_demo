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

          image_url_id = "image-url-#{image.id}"

          div image.url,
            class: "image-url",
            flow_id: image_url_id,
            onClick: "copyToClipboard('#{image_url_id}')"
        end
      end
    end

    copy_to_clipboard_script
  end

  private def copy_to_clipboard_script
    raw %(
      <script>
      function copyToClipboard(element) {
        var $toCopy = document.querySelector('[flow-id=' + element + ']');
        
        if ($toCopy) {
          var $tempCp = document.createElement('input');
          document.body.appendChild($tempCp)

          console.log('toCopy: ', $toCopy);

          $tempCp.value = $toCopy.innerHTML
          $tempCp.select();
  
          document.execCommand('copy');
          document.body.removeChild($tempCp);
        }
        $toCopy = null;
      }
      </script>
    )
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
