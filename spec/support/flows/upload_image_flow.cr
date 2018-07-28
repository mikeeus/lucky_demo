class UploadImageFlow < BaseFlow
  def upload_image(filepath)
    visit Home::Index
    fill_form ImageForm,
      file: filepath
    click "@upload-image"
  end

  def should_create_image(filepath)
    file = File.open(filepath)
    file.should_not be_nil

    image = ImageQuery.new.filename(File.basename(file.path)).first?
    image.should_not be_nil
  end
end
