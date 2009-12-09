#!/usr/bin/env ruby

unless ARGV[0]
  puts 'Usage: newpost "the post title"'
  exit(-1)
end

blog_prefix = ENV['HOME'] + "/Desktop/"
date_prefix = Time.now.strftime("%Y-%m-%d_%H-%M")
postname = ARGV[0].strip.downcase.gsub(/ /, '-')
post = "#{blog_prefix}/#{date_prefix}-#{postname}.textile"

header = <<-END
---
layout: post
title: "#{ARGV[0]}"
tags:
---



END

File.open(post, 'w') do |f|
  f << header
end

system("mate", "-a", post)
