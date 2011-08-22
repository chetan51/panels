require 'cgi'
require 'jsmin'
directory "lib"

task :compile_bookmarklet => "lib" do
  sh "coffee -o lib -c src/bookmarklet.coffee"
end

task :compile_index => "lib" do
  bookmarklet = File.open("lib/bookmarklet.js", "rb")
  bookmarklet_contents = bookmarklet.read
  bookmarklet_contents = JSMin.minify(bookmarklet_contents)
  bookmarklet_contents = CGI.escapeHTML(bookmarklet_contents)
  
  File.open("lib/index.html",'w+') do |index|
    index_contents = File.read("src/index.html")
    index_contents['{{code}}'] = bookmarklet_contents
    index.puts index_contents
  end
end

task :copy_files => "lib" do
  sh "cp src/includes/* lib"
end

task :default => [:compile_bookmarklet, :compile_index, :copy_files]