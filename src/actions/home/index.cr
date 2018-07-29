class Home::Index < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  get "/" do
    if current_user?
      redirect Me::Show
    else
      images = ImageQuery.new.owner_ip(current_ip)

      render Home::IndexPage, form: ImageForm.new, images: images
    end
  end
end
