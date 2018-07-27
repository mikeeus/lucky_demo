class Home::IndexPage < GuestLayout
  include React::Component

  def content
    h1 "React Component"
    tag "component"

    # react_component
  end
end
