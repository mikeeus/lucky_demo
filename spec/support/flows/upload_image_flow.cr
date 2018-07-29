class UploadImageFlow < BaseFlow
  def upload_image(filepath)
    visit Home::Index

    fill_form ImageForm,
      image: File.expand_path(filepath)
    click "@upload-image"
  end

  def image_should_be_created(filepath)
    image = find_image_by_filename?(File.basename(filepath))
    image.should_not be_nil
  end

  def image_should_not_be_created(filepath)
    image = find_image_by_filename?(File.basename(filepath))
    image.should be_nil
  end

  private def find_image_by_filename?(filename)
    ImageQuery.new.filename.ilike("%#{filename}%").first?
  end
end
