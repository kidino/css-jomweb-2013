#!/usr/bin/env ruby

require 'rubygems'
require 'rmagick'

path=ARGV[0];

img = Magick::Image::read(path)[0]


if (img.columns * img.rows) > 90000
  puts "This operation would result in a very large file. I dont want to convert your file :P"
  puts "Exiting..."
  exit
end

File.open(path+".html", 'w') do |file|

csscolor = [];
elemts = "<div id='i2h-img'>"

img.each_pixel do |pixel, col, row|
  r = (pixel.red/257).to_s(16).rjust(2, '0');
  g = (pixel.green/257).to_s(16).rjust(2, '0');
  b = (pixel.blue/257).to_s(16).rjust(2, '0');
  a = (pixel.opacity/257).to_s(16).rjust(2, '0');
  
  # /257 because of 16 bits
  hex = "#{r}#{g}#{b}"
  
  elemts += ("<span style='background:##{hex}'></span>")
  if col+1 == img.columns
    elemts += ("<br>")
  end
end

file.write("<style type='text/css'>")
file.write("*{margin:0;padding:0;line-height:0;letter-spacing:0;} #i2h-img span {display:inline-block;float:left;width:1px;height:1px;}#i2h-img br {clear:both;}")
file.write("</style>")

file.write(elemts+"</div>")

end
