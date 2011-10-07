
class TocEntryGenerator
  TOC_CLASSES = %w(
      set book part chapter appendix bridgehead glossary index sidebar
      sect1 sect2 sect3 sect4 sect5 section simplesect
  )

  def self.digest_book_html_into_database(monolithic_html_file_name)
    @content_update = ContentUpdate.last

    monolithic_html_content = IO.read monolithic_html_file_name
    monolithic_html = Nokogiri::HTML monolithic_html_content do |config|
      config.noent.xinclude.noblanks.nocdata.nonet.strict
    end


    # do depth-first recursion to find all TOC entry elements
    @discarded_top_level_entry = false
    TocEntryGenerator.toc_elements_from_html_to_db(
        monolithic_html.css('body').first )


    # normalize indentation numbers for imported TOC items
    toc_entries = @content_update.toc_entries
    used_levels = toc_entries.each.map(&:indent_level).uniq.sort
    toc_entries.each do |entry|
      old_level = entry.indent_level
      new_level = old_level <= 15 ? used_levels.index(old_level) : nil
      entry.update_attribute(:indent_level, new_level)
    end
  end

  private

  def self.toc_elements_from_html_to_db(parent_node)
    parent_node.children.each do |node|
      if node.type == 1 && node.name == 'div' &&
          TOC_CLASSES.include?(node['class']) && node['title'].present?
        anchor = node.css('a').first
        tag = first_non_div_tag_under node
        if tag
          indent_level = 20
          name = tag.name
          if name == 'h1'
            indent_level = case node['class']
              when 'part'
                0
              when 'book'
                -1
              when 'set'
                -2
              else
                19
            end
          elsif name == 'h2'
            indent_level = case node['class']
              when 'chapter', 'appendix', 'glossary', 'index'
                1
              else
                2
            end
          elsif name =~ /^h(\d+)$/
            indent_level = $1.to_i
          end
        end

        if @discarded_top_level_entry
          TocEntry.create!(
              :content_update => @content_update,
              :docbook_element => node['class'],
              :entry_text => node['title'],
              :html_anchor => anchor ? anchor['id'] : nil,
              :indent_level => indent_level
          )
        else
          @discarded_top_level_entry = true
        end
      end
      toc_elements_from_html_to_db node
    end
  end
end
