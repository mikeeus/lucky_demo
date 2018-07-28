class Image < BaseModel
  table :images do
    column filename : String
    column owner_ip : String
    column views : Int64
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
    File.delete(full_path)
    delete
  end
end
