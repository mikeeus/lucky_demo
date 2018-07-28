class Home::Index < BrowserAction
  include Auth::SkipRequireSignIn
  unexpose current_user

  get "/" do
    pp context.request.headers["X-Forwarded-For"]

    if current_user?
      redirect Me::Show
    else
      render Home::IndexPage
    end
  end
end
