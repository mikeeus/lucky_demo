class Home::IndexPage < GuestLayout
  needs form : ImageForm

  def content
    render_form(@form)
  end

  private def render_form(f)
    form_for Images::Create, enctype: "multipart/form-data" do
      text_input f.image, type: "file", flow_id: "file-input"

      submit "Upload Image", flow_id: "upload-image"
    end
  end
end
