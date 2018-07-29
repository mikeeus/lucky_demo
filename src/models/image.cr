class Image < BaseModel
  VALID_FORMATS = %w[jpg jpeg png gif]

  table :images do
    column filename : String
    column owner_ip : String
    column views : Int32
  end

  def url
    "#{Lucky::RouteHelper.settings.base_uri}/#{path}"
  end

  def path
    if Lucky::Env.test?
      "assets/images/test/#{self.filename}"
    else
      "assets/images/#{self.filename}"
    end
  end

  def full_path
    "public/#{path}"
  end

  def delete!
    if File.exists?(full_path)
      File.delete(full_path)
    end

    delete
  end
end
