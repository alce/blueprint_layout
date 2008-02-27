class BlueprintLayoutGenerator < Rails::Generator::NamedBase

  default_options :template => :haml

  def manifest
    record do |m|
      bp_root = 'public/stylesheets/blueprint'
      
      # prepare directories
      m.directory 'app/views/layouts' #just in case it does'n exist
      m.directory bp_root
      %w(compressed lib plugins tests docs).each {|d| m.directory "#{bp_root}/#{d}"}
      %w(buttons css-classes fancy-type).each {|d| m.directory "#{bp_root}/plugins/#{d}"}
      m.directory "#{bp_root}/plugins/buttons/icons"
      
      # compressed
      m.file "blueprint/compressed/print.css", "#{bp_root}/compressed/print.css"
      m.file "blueprint/compressed/screen.css", "#{bp_root}/compressed/screen.css"
      
      # lib
      %w(forms.css grid.css ie.css reset.css typography.css grid.png).each do |f|
        m.file "blueprint/lib/#{f}", "#{bp_root}/lib/#{f}"
      end
      
      # plugins
      %w(buttons.css Readme).each do |f| 
        m.file "blueprint/plugins/buttons/#{f}", "#{bp_root}/plugins/buttons/#{f}"
      end
      
      %w(cross key tick).each do |f|
        m.file "blueprint/plugins/buttons/icons/#{f}.png", "#{bp_root}/plugins/buttons/icons/#{f}.png"
      end
      
      %w(css-classes.css Readme).each do |f|
        m.file "blueprint/plugins/css-classes/#{f}", "#{bp_root}/plugins/css-classes/#{f}"
      end
      
      # tests
      %w(elements forms grid index plugins sample).each do |f|
        m.file "blueprint/tests/#{f}.html", "#{bp_root}/tests/#{f}.html"
      end
      
      %w(fancy-type-compressed.css fancy-type.css Readme).each do |f|
        m.file "blueprint/plugins/fancy-type/#{f}", "#{bp_root}/plugins/fancy-type/#{f}"
      end
      
      m.file "blueprint/tests/test.jpg", "#{bp_root}/tests/test.jpg"
      
      # docs
      %w(Readme Changelog License).each do |f|
        m.file "blueprint/docs/#{f}" , "#{bp_root}/docs/#{f}"
      end

      m.file 'blueprint/print.css', "#{bp_root}/print.css"
      m.file 'blueprint/screen.css', "#{bp_root}/screen.css"
     
      if options[:template] == :erb
        m.template "layout.erb", "app/views/layouts/#{file_name}.html.erb"
        m.file "main.css", "public/stylesheets/bpmain.css"
      elsif options[:template] == :haml
        dir = "public/stylesheets/sass"
        m.directory dir
        m.template "layout.haml", "app/views/layouts/#{file_name}.html.haml"
        m.file "main.sass", "#{dir}/bpmain.sass"
        m.file "colors.sass", "#{dir}/bpcolors.sass"
      end
    end
  end
  
  def banner
    "Usage: #{$0} blueprint_layout TemplateName --templating_engine"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-e", "--erb", 
    "Generates an erb layout and a stylesheet") { |v| options[:template] = :erb}
    opt.on("-H","--haml", 
    "Generates a haml layout and two sass files (default)") { |v| options[:template] = :haml} 
    
  end
end