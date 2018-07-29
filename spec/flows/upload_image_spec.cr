require "../spec_helper"

describe "Upload Image flow" do

  Spec.after_each do
    ImageQuery.new.map(&.delete!)
  end

  it "works with valid image" do
    flow = UploadImageFlow.new

    flow.upload_image(valid_image_path)
    flow.image_should_be_created(valid_image_path)
  end

  it "doesnt work with image above 250kb" do
    flow = UploadImageFlow.new

    flow.upload_image(too_big_image_path)
    flow.image_should_not_be_created(too_big_image_path)
  end

  it "doesnt work with dimensions over 1000x1000" do
    flow = UploadImageFlow.new

    flow.upload_image(too_tall_image_path)
    flow.image_should_not_be_created(too_tall_image_path)
  end

  it "doesnt work with image of the wrong format" do
    flow = UploadImageFlow.new

    flow.upload_image(wrong_format_image_path)
    flow.image_should_not_be_created(wrong_format_image_path)
  end
end

private def valid_image_path
  "public/assets/images/test/perfect_960x981_56kb.jpg"
end

private def too_tall_image_path
  "public/assets/images/test/too_tall_1001x1023_95kb.jpg"
end

private def too_big_image_path
  "public/assets/images/test/too_big_900x900_256kb.jpg"
end

private def wrong_format_image_path
  "public/assets/images/test/wrong_format.bmp"
end
