class Home::IndexPage < GuestLayout
  include Layout::HeaderComponent

  needs form : ImageForm
  needs images : ImageQuery

  def content
    render_header

    div class: "homepage-container" do
      h1 "Welcome, Add your files here!"

      render_happy_form(@form)
      
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

  private def render_happy_form(f)
    form_for Images::Create, enctype: "multipart/form-data", id: "upload-form" do
      div class: "drag-drop-container" do
        para "Drag or Drop Image", class: "drag-drop"
  
        img src: asset("images/upload.png")
  
        para class: "or-click" do
          text "Or"
          br
          span "Click to Upload"
        end

        text_input f.image, type: "file", id: "file-input"
      end

      submit "Upload Image", flow_id: "upload-button", id: "form-submit", disabled: "true"
    end

    ul do
      f.image.errors.each do |err|
        li "Image #{err}", class: "error"
      end
    end

    raw %(<script>#{upload_script}</script>)
  end
    
  private def upload_script
    <<-JS
      var happyForm = document.getElementById('upload-form');
      var happyInput = document.getElementById('file-input');
      var happySubmit = document.getElementById('form-submit');
      happyForm.addEventListener('change', () => {
        happySubmit.removeAttribute('disabled');
        document.querySelector('p.or-click').innerHTML = "<h3>Item selected</h3>";
      });
    JS
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
end
