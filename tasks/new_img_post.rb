#!/usr/bin/env ruby

unless ARGV.length == 5
  puts 'Usage: new_img_post "the post title" "image_link" "source_title" "source_link" "tag1;tag2;tag3"'
  exit(-1)
end


blog_prefix = ENV['HOME'] + "/Desktop/"
date_prefix = Time.now.strftime("%Y-%m-%d_%H-%M")
postname = ARGV[0].strip.downcase.gsub(/ /, '-')
post = "#{blog_prefix}/#{date_prefix}-#{postname}.textile"
tags = "- #{ARGV[4].gsub(/;/, "\n- ")}"

header = <<-END
---
layout: post
title: "#{ARGV[0]}"
tags:
#{tags}
---

<a href="#{ARGV[1]}" class="lightbox" id="img"><img src="#{ARGV[1]}"/></a>

Source "#{ARGV[2]}":#{ARGV[3]}

END

File.open(post, 'w') do |f|
  f << header
end

