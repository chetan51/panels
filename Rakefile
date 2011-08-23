require 'cgi'
require 'jsmin'

panels = [
  { :id => "hacker", :name => "Hacker", :service_name => "Hacker News" },
  { :id => "reddit", :name => "Reddit", :service_name => "Reddit" }
]

=begin

task :compile_bookmarklet => "lib" do
  sh "coffee -o lib -c src/bookmarklet.coffee"
end

task :compile_index => "lib" do
  bookmarklet = File.open("lib/bookmarklet.js", "rb")
  bookmarklet_contents = bookmarklet.read
  
  # Minify bookmarklet javascript
  bookmarklet_contents = JSMin.minify(bookmarklet_contents)
  
  # Escape HTML in bookmarklet
  bookmarklet_contents = CGI.escapeHTML(bookmarklet_contents)
  bookmarklet_contents.gsub!('%', '%25')
  
  # Insert bookmarklet into index page
  File.open("lib/index.html",'w+') do |index|
    index_contents = File.read("src/index.html")
    index_contents['{{code}}'] = bookmarklet_contents
    index.puts index_contents
  end
end

task :copy_files => "lib" do
  sh "cp src/includes/* lib"
end

=end

task :create_directories do
  for panel in panels do
    FileUtils.mkdir_p("lib/" + panel[:id])
  end
end

task :compile_bookmarklets do
  for panel in panels do
    File.open("lib/" + panel[:id] + "/bookmarklet.coffee",'w+') do |bookmarklet|
      # Compose bookmarklet
      shared_bookmarklet_contents = File.read("src/shared/bookmarklet.coffee")
      bookmarklet_contents = File.read("src/" + panel[:id] + "/_bookmarklet.coffee")
      final_bookmarklet_contents = shared_bookmarklet_contents
      final_bookmarklet_contents['{{code}}'] = bookmarklet_contents
      
	# Replace variables
      final_bookmarklet_contents.gsub!("\{\{panel_id\}\}", panel[:id])
      
      bookmarklet.puts final_bookmarklet_contents
    end
  end
end

task :convert_bookmarklets do
  for panel in panels do
    # Compile CoffeeScript
    sh "coffee -o lib/" + panel[:id] + " -c lib/" + panel[:id] + "/bookmarklet.coffee"
      
    bookmarklet_contents = File.read("lib/" + panel[:id] + "/bookmarklet.js")
    
    File.open("lib/" + panel[:id] + "/bookmarklet.js",'w+') do |bookmarklet|
      # Minify bookmarklet javascript
      bookmarklet_contents = JSMin.minify(bookmarklet_contents)
      
      # Escape HTML in bookmarklet
      bookmarklet_contents = CGI.escapeHTML(bookmarklet_contents)
      bookmarklet_contents.gsub!('%', '%25')
      
      bookmarklet.puts bookmarklet_contents
    end
  end
end

task :compile_indexes do
  for panel in panels do
    File.open("lib/" + panel[:id] + "/index.html",'w+') do |index|
      index_contents = File.read("src/shared/index.html")
      
      # Replace variables
      index_contents.gsub!("\{\{panel_id\}\}", panel[:id])
      index_contents.gsub!("\{\{panel_name\}\}", panel[:name])
      index_contents.gsub!("\{\{service_name\}\}", panel[:service_name])
      
      # Insert bookmarklet
      bookmarklet_contents = File.read("lib/" + panel[:id] + "/bookmarklet.js")
      index_contents['{{bookmarklet}}'] = bookmarklet_contents
      
      # Insert HTML
      other_panels_contents = File.read("src/" + panel[:id] + "/_other_panels.html")
      index_contents['{{other_panels}}'] = other_panels_contents
      
      index.puts index_contents
    end
  end
end

task :copy_shared do
  for panel in panels do
    sh "cp -r src/shared/includes/* lib/" + panel[:id]
    sh "cp -r src/" + panel[:id] + "/includes/* lib/" + panel[:id]
  end
end

#task :default => [:compile_bookmarklet, :compile_index, :copy_files]
task :default => [:create_directories, :compile_bookmarklets, :convert_bookmarklets, :compile_indexes, :copy_shared]