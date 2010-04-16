#-------------------------------------------------------
#   install.sh - Overview
#-------------------------------------------------------
#   This is the Ruby-based method to install dotfiles. I
#   realize that install.sh does exactly the same thing,
#   but in the interest of experimenting with Rakefiles,
#   I thought I would give Ruby enthusiasts a way to
#   accomplish installation. :)

#--------------------------------------------------
#   If the user simply runs `rake`, display the
#   possible options
#--------------------------------------------------
task :default do
  puts "Usage: rake [option]"
  puts "Possible options: install, gc"
end

#--------------------------------------------------
#   Task to regenerate .gitconfig
#--------------------------------------------------
task :gc do
  gitconfig_setup
end

#--------------------------------------------------
#   Task to install the entirety of dotfiles
#--------------------------------------------------
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if !%w(gitignore zshrc).include? file or file =~ /.*~$/
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
  
  gitconfig_setup
end

#--------------------------------------------------
#   Generates a new .gitconfig with user-supplied
#   input and places it in the user's home directory
#--------------------------------------------------
def gitconfig_setup
  name = `git config --global user.name`.strip
  email = `git config --global user.email`.strip
  
  if File.exist?(File.join(ENV['HOME'], ".gitconfig"))
    system `rm "$HOME/.gitconfig"`
    system `cp "$PWD/gitconfig" "$HOME/.gitconfig"`
  else
    system `cp "$PWD/gitconfig" "$HOME/.gitconfig"`
  end
  
  puts "Git Name: (leave blank to default to '#{name}')"
  new_name = STDIN.gets.strip
  
  puts "Git Email: (leave blank to default to '#{email}')"
  new_email = STDIN.gets.strip
  
  if new_name == ""
    new_name = name
  end
  
  if new_email == ""
    new_email = email
  end

  `git config --global user.name "#{new_name}"`
  `git config --global user.email "#{new_email}"`
  `git config --global core.excludesfile ~/.gitignore`
end

#--------------------------------------------------
#   Creates a symbolically linked "." version of a
#   file in the user's home directory
#--------------------------------------------------
def link_file(file)
  puts "Linking ~/.#{file}..."
  system `ln -s "$PWD/#{file}" "$HOME/.#{file}"`
end

#--------------------------------------------------
#   Replaces a "." symlink in the user's home 
#   directory
#--------------------------------------------------
def replace_file(file)
  puts "Removing old ~/.#{file}..."
  system `rm "$HOME/.#{file}"`
  link_file(file)
end
