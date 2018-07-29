class ImageBox < LuckyRecord::Box
  def initialize
    filename "perfect_image.jpg"
    owner_ip "0.0.0.0"
    views 1
  end

  def delete!
    delete
  end
end
