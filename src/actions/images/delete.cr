class Images::Delete < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  route do
    image = ImageQuery.find(id)

    if image.owner_ip == current_ip
      image.delete!
      flash.success = "Image succesfully deleted!"
      redirect to: Home::Index
    else
      flash.danger = "You are not authorized to delete this image"
      redirect to: Home::Index
    end
  end
end
