require "../spec_helper"

describe "Images flow" do
  Spec.after_each do
    ImageQuery.new.map(&.delete!)
  end

  describe "test_images" do
    it "should have 4 images" do
      Dir.glob("public/assets/images/test/*").size.should eq 4
    end
  end

  describe "uploading" do    
    it "works with valid image" do
      flow = ImagesFlow.new
  
      flow.upload_image(valid_image_path)
      flow.image_should_be_created(valid_image_path)
    end
  
    it "doesnt work with image above 250kb" do
      flow = ImagesFlow.new
  
      flow.upload_image(too_big_image_path)
      flow.image_should_not_be_created(too_big_image_path)
    end
  
    it "doesnt work with dimensions over 1000x1000" do
      flow = ImagesFlow.new
  
      flow.upload_image(too_tall_image_path)
      flow.image_should_not_be_created(too_tall_image_path)
    end
  
    it "doesnt work with image of the wrong format" do
      flow = ImagesFlow.new
  
      flow.upload_image(wrong_format_image_path)
      flow.image_should_not_be_created(wrong_format_image_path)
    end
  end

  describe "displays" do
    it "own images" do
      flow = ImagesFlow.new
      owned = ImageBox.new.owner_ip("local").create
      not_owned = ImageBox.new.owner_ip("not-owned").create

      flow.homepage_should_display_image(owned.id)
      flow.homepage_should_not_display_image(not_owned.id)
    end
  end

  describe "deleting" do
    it "is allowed for owner" do
      flow = ImagesFlow.new

      flow.upload_image(valid_image_path)

      image = ImageQuery.new.first

      flow.delete_image_from_homepage(image.id)
      flow.image_should_not_exist(image.id)
    end

    it "is not allowed for other ip addresses" do
      flow = ImagesFlow.new
      not_owned = ImageBox.new.owner_ip("not-local").create

      flow.delete_image_from_action(not_owned.id)
      flow.image_should_exist(not_owned.id)
    end
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
  "public/assets/images/test/wrong_format_240x245_235kb.bmp"
end
