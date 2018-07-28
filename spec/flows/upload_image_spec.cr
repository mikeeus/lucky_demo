require "../spec_helper"

describe "Upload Image flow" do
  it "works" do
    flow = UploadImageFlow.new

    flow.upload_image(valid_image_path)
    flow.should_create_image(valid_image_path)
  end

end

def valid_image_path
  "public/assets/images/test/perfect_960x981_56kb.jpg"
end
