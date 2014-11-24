#!/usr/bin/env ruby

base_dir = File.join(File.dirname(__FILE__),'../../..')
src_dir = File.join(base_dir, "/src/main/asciidoc")
require 'asciidoctor'
require 'optparse'

options = {}
file = "#{src_dir}/README.adoc"

OptionParser.new do |o|
  o.on('-o OUTPUT_FILE', 'Output file (default is stdout)') { |file| options[:to_file] = file unless file=='-' }
  o.on('-h', '--help') { puts o; exit }
  o.parse!
end

file = ARGV[0] if ARGV.length>0

srcDir = File.dirname(file)
out = "// Do not edit this file (e.g. go instead to src/main/asciidoc)\n\n"
doc = Asciidoctor.load_file file, safe: :safe, parse: false, attributes: 'allow-uri-read'
out << doc.reader.read

unless options[:to_file]
  puts out
else
  File.open(options[:to_file],'w+') do |file|
    file.write(out)
  end
end