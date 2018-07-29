class ImagesFlow < BaseFlow
  def upload_image(filepath)
    visit Home::Index

    fill_form ImageForm,
      image: File.expand_path(filepath)
    click "@upload-image"
  end

  def homepage_should_display_image(id)
    visit Home::Index
    image(id).should be_on_page
  end

  def homepage_should_not_display_image(id)
    visit Home::Index
    image(id).should_not be_on_page
  end

  def delete_image_from_homepage(id)
    visit Home::Index
    click "@delete-image-#{id}"
  end

  def delete_image_from_action(id)
    visit Images::Delete.with(id: id)
  end

  def image_should_be_created(filepath)
    image = find_image_by_filename?(File.basename(filepath))
    image.should_not be_nil
  end

  def image_should_not_be_created(filepath)
    image = find_image_by_filename?(File.basename(filepath))
    image.should be_nil
  end

  def image_should_exist(id)
    ImageQuery.find(id).should_not be_nil
  end

  def image_should_not_exist(id)
    ImageQuery.new.id(id).first?.should be_nil
  end

  private def find_image_by_filename?(filename)
    ImageQuery.new.filename.ilike("%#{filename}%").first?
  end

  private def image(id)
    el("@image-#{id}")
  end
end
