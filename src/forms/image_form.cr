require "uuid"

class ImageForm < Image::BaseForm
  fillable filename
  fillable views
  fillable owner_ip

  virtual image : String

  needs file : Lucky::UploadedFile, on: :create
  needs ip : String, on: :create

  getter new_filename

  def prepare
    save_image
    views.value = 1
    filename.value = new_filename
    owner_ip.value = ip
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
