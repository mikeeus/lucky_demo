class Images::Index < BrowserAction
  include Auth::SkipRequireSignIn

  route do
    redirect to: Home::Index
  end
end
