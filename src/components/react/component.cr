module React::Component
  def react(class_name : String, tag : String? = "div")
    tag tag, "data-react-class": class_name
  end

  def react(class_name : String, tag : String? = "div", &block)
    tag tag, "data-react-class": class_name do
      yield
    end      
  end

  def react(class_name : String, props : NamedTuple | JSON::Any, tag : String? = "div")
    tag tag, "data-react-class": class_name, "data-react-props": props.to_json
  end

  def react(class_name : String, props : NamedTuple | JSON::Any, tag : String? = "div", &block)
    tag tag, "data-react-class": class_name do
      yield
    end      
  end
end
