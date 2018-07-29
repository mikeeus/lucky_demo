class Images::Create < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  route do
    file = params.nested_file?(:image)["image"]?

    if file.nil? || file.metadata.filename.nil?
      flash.danger = "Please select a file to upload"
      redirect to: Home::Index
    else
      ImageForm.create(file: file, ip: current_ip) do |form, image|
        if image
          flash.success = "Image successfuly uploaded from #{current_ip}!"
          redirect to: Home::Index
        else
          flash.danger = "Image upload failed"
          redirect to: Home::Index
        end
      end
    end
  end
end
