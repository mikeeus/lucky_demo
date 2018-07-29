class Images::Create < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  route do
    file = params.nested_file?(:image)["image"]?

    if is_invalid(file)
      flash.danger = "Please select a file to upload"
      redirect to: Home::Index
    else
      ImageForm.create(file: file.not_nil!, ip: current_ip) do |form, image|
        if image
          flash.success = "Image successfuly uploaded from #{current_ip}!"
          redirect to: Home::Index
        else
          images = ImageQuery.new.owner_ip(current_ip)

          flash.danger = "Image upload failed"
          render Home::IndexPage, form: form, images: images
        end
      end
    end
  end

  private def is_invalid(file)
    file.nil? || file.metadata.filename.nil? || file.not_nil!.metadata.filename.not_nil!.empty?
  end
end
