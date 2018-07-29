abstract class BrowserAction < Lucky::Action
  include Lucky::ProtectFromForgery
  # This module provides current_user, sign_in, and sign_out methods
  include Authentic::ActionHelpers(User)

  # When testing you can skip normal sign in by using `vist` with the `as` param
  #
  # flow.visit Me::Show, as: UserBox.create
  include Auth::SignInThroughBackdoor

  # By default all actions require sign in, unless you use the
  # `Auth::SkipRequireSignIn` module in `src/mixins/auth/skip_require_sign_in.cr`
  include Auth::RequireSignIn

  def current_ip
    current_ip?.not_nil!
  end

  private def current_ip?
    if Lucky::Env.production?
      context.request.headers["X-FORWARDED-FOR"]?
    else
      "local"
    end
  end

  # `expose` means that `current_user` will be passed to pages automatically.
  #
  # In default Lucky apps, the `MainLayout` declares it `needs current_user : User`
  # so that any page that inherites from MainLayout can use the `current_user`
  #
  # Note that using the `Auth::RedirectIfSignedIn` mixin will `unexpose` the
  # `current_user` since there will never be a signed in user for those actions.
  expose current_user

  # This method tells Authentic how to find the current user
  private def find_current_user(id) : User
    UserQuery.find(id)
  end
end
