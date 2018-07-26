require "../../../tasks/transpile_jsx.cr"

module React::Base
  macro included
    {% name = @type.name.gsub(/React::/ , "").underscore %}
    @name : String = "{{name}}"

    def render_tag
      tag @name
    end

    def transpiled_script
      ARGV.push(@name)
      t = TranspileJsx.new.call
      pp t
      t
    end

    def component_script
      transpiled = transpiled_script
      if transpiled.nil?
        nil
      else
        raw %(
          <script>
            #{transpiled}
          </script>
        )
      end
    end
  end
end
