task :default do
  puts "Run `rake install` to install the dotfiles configuration system."
end

task :install do
  name = `git config --global user.name`.strip
  email = `git config --global user.email`.strip

  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE].include? file
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "Overwrite ~/.#{file}? [yNaq] "
        case STDIN.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "Skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  puts "Git Name: (leave blank to default to '#{name}')"
  new_name = STDIN.gets.strip

  puts "Git Email: (leave blank to default to '#{email}')"
  new_email = STDIN.gets.strip

  if new_email == ""
    new_email = email
  end

  if new_name == ""
    new_name = name
  end

  `git config --global user.name "#{new_name}"`
  `git config --global user.email "#{new_email}"`

end

def replace_file(file)
  puts "Removing old ~/.#{file}..."
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end
 
def link_file(file)
  puts "Linking ~/.#{file}..."
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end