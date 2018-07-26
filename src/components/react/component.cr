module React::Component
  include React::Base

  def react_component
    render_tag

    component_script
  end
end