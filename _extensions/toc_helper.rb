module Jekyll
    class Site

        def makeToc
            # Find and substitute id's
            self.posts.each { |post| self.substituteTitles(post, "Article Contents") if post.content =~ /<!-- TOC -->/ }
        end

        # Configure all headers with an ID for the ToC and save ToC structure
        def substituteTitles(post, toc_title)
            items = Array.new

            post.content.gsub!(/h(\d)\. (\S+[ \S]*)/) do |r|
                level = $1
                title = $2
                link_text = title.gsub(/[_*]/, "") # title: bla *bla* => bla_bla
                id = link_text.gsub(/\W+/, "_").gsub(/[\W_]+$/, '') # title Bla?_bla*blbla => Bla_bla_blbla
                items << { :link_text => link_text, :level => level.to_i, :id => id }
                "h#{level}(##{id}). #{title}"
            end
            self.process_toc(post, items, toc_title)
        end

        # Create the Textile ToC from the items
        def process_toc(post, items, toc_title)
            begin
                toc = "<div class=\"toc\">\n"
                toc += "p(#toc_title). #{toc_title}\n"
                base_level = items.first[:level] - 1
                items.each do |item|
                    depth = item[:level] - base_level
                    toc += "#{"*"*depth}(depth_#{depth}) \"(toc_link)#{item[:link_text]}\":##{item[:id]}\n"
                end

                toc += "\n</div>"
                post.content.gsub!(/<!-- TOC -->/, toc)
            rescue
                puts "Depth error in #{post.title}"
                items.each do |item|
                    base_level = items.first[:level] - 1
                    puts "Level: #{item[:level]} Depth: #{item[:level] - base_level} Title: #{item[:link_text]}"
                end
            end
        end
    end

    AOP.before(Site, :render) do |site_instance, result, args|
        site_instance.makeToc
    end
end
