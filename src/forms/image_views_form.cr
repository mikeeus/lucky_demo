class ImageViewsForm < Image::BaseForm
  fillable views
  fillable filename
  fillable owner_ip

  def prepare
    views.value = views.value.not_nil! + 1
  end
end 
