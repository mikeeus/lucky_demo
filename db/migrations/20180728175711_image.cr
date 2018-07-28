class Image::V20180728175711 < LuckyMigrator::Migration::V1
  def migrate
    create :images do
      add filename : String
      add owner_ip : String
      add views : Int32
    end

    execute "CREATE INDEX owner_ip_index ON images (owner_ip);"
  end

  def rollback
    drop :images
  end
end
