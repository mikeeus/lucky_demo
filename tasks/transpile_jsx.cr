class TranspileJsx < LuckyCli::Task
  banner "Transpile jsx file to js"

  def call
    name = ARGV[0]
    if !name
      return
    end

    jsx_files = Dir.glob("src/js/**/*.jsx")
                   .select(&.includes? "/#{name}.jsx")
    pp jsx_files

    if jsx_files.empty?
      return
    end

    output = IO::Memory.new
    error = IO::Memory.new

    Process.run babel_command, babel_args(jsx_files.first), output: output, error: error

    unless error.to_s.empty?
      pp error.to_s
    end

    pp output.to_s
    output.to_s
  end

  private def babel_command
    "node_modules/babel-cli/bin/babel.js"
  end

  private def babel_args(path)
    ["--presets", "react,env,minify", "--plugins", "transform-class-properties,transform-es2015-modules-commonjs", path]
  end
end
