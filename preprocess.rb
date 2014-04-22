require 'redcarpet'

class GitRenderer < Redcarpet::Render::HTML
  def preprocess(doc)
    doc.gsub!(/^<<(.*)/, '# REPLACED LINE')
  end
end

renderer = Redcarpet::Markdown.new(GitRenderer, fenced_code_blocks: true)
markdown = renderer.render(File.read('test.md'))
File.write('preprocessed.md', markdown)
