require "uuid"
require "crymagick"

class ImageForm < Image::BaseForm
  fillable filename
  fillable views
  fillable owner_ip

  virtual image : String

  needs file : Lucky::UploadedFile, on: :create
  needs ip : String, on: :create

  getter new_filename
  getter crymagick_image : CryMagick::Image?

  def prepare
    validate_is_correct_size
    validate_is_correct_dimensions
    validate_is_correct_type

    if errors.empty?
      save_image

      views.value = 1
      filename.value = new_filename
      owner_ip.value = ip
    end
  end

  private def validate_is_correct_type
    ext = crymagick_image.type

    unless Image::VALID_FORMATS.includes? "#{ext}".downcase
      image.add_error "type should be jpg, jpeg, gif or png but was #{ext}"
    end
  end

  private def validate_is_correct_size
    size = crymagick_image.size
    if size > 250_000
      image.add_error "size should be less than 250kb but was #{size / 1000}kb"
    end
  end

  private def validate_is_correct_dimensions
    dimensions = crymagick_image.dimensions

    if dimensions.first > 1000
      image.add_error "width should be less than 1000px, but was #{dimensions.first}px"
    end

    if dimensions.last > 1000
      image.add_error "height should be less than 1000px, but was #{dimensions.last}px"
    end
  end

  private def crymagick_image
    @crymagick_image ||= CryMagick::Image.open(uploaded.tempfile.path)
  end

  private def uploaded
    file.not_nil!
  end

  private def save_image
    File.write(save_path, File.read(uploaded.tempfile.path))
  end

  private def new_filename
    @new_filename ||= "#{UUID.random}_#{uploaded.metadata.filename}"
  end

  private def image_path
    if Lucky::Env.test?
      "assets/images/test/" + new_filename
    else
      "assets/images/" + new_filename
    end
  end

  private def save_path
    "public/" + image_path
  end
end
