require 'rugged'
require 'redcarpet'
require 'json'

module Commitate

  class Parser
    REGEX = /^>>\[(.*)\]\((.*)\)(\{(.*)\})*/

    attr_reader :filename, :commit_sha

    def initialize(markdown)
      match = REGEX.match(markdown)
      @filename = match[1]
      @commit_sha = match[2]
      @args = match[3] ? JSON.parse(match[3]) : {}
    end

    def lines
      @args['lines']
    end
  end

  class Processor
    attr_reader :markdown

    def initialize(markdown)
      @markdown = markdown
      parser = Parser.new(markdown)
      @filename = parser.filename
      @commit_sha = parser.commit_sha
      @lines = parser.lines
    end

    def process
      repo = Rugged::Repository.new('.')
      commit = repo.lookup(@commit_sha)
      ''.tap do |content|
        commit.tree.each do |e|
          if e[:type] == :blob && e[:name] == @filename
            blob = repo.lookup(e[:oid])
            if @lines
              content << blob.content.lines.first
            else
              content << blob.content
            end
          end
        end
      end
    end
  end

  class Renderer < Redcarpet::Render::HTML
    GITDOWN_LINE = /^>>(.*)/

    def preprocess(doc)
      doc.gsub!(GITDOWN_LINE) do |markdown|
        Processor.new(markdown).process
      end
    end
  end

end

renderer = Redcarpet::Markdown.new(Commitate::Renderer, fenced_code_blocks: true)
markdown = renderer.render(File.read('test.md'))
File.write('preprocessed.md', markdown)
