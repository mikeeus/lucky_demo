class Home::Index < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  get "/" do
    if current_user?
      redirect Me::Show
    else
      render Home::IndexPage
    end
  end
end
