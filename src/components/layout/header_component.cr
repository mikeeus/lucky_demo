module Layout::HeaderComponent
  def render_header
    header class: "homepage-header" do
      div class: "wrapper" do
        img src: asset("images/happy.png")
        link "Happy Host", to: Home::Index
      end
    end
  end
end
