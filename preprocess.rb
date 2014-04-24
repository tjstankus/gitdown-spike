require 'rugged'
require 'redcarpet'

class GitdownMdParser

  REGEX = /^<<\[(.*)\]\((.*)\)/

  def initialize(markdown)
    match = REGEX.match(markdown)
    @description = match[1]
    @args = parse_args(match[2])
  end

  def filename
    @args['file']
  end

  def commit_sha
    @args['sha']
  end

  private

  def parse_args(args)
    Hash.new.tap do |h|
      args.split(',').each do |pair|
        key, value = pair.split(':').collect(&:strip)
        h[key] = value
      end
    end
  end
end

class Gitdown

  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
    parser = GitdownMdParser.new(markdown)
    @filename = parser.filename
    @commit_sha = parser.commit_sha
  end

  def process
    repo = Rugged::Repository.new('.')
    commit = repo.lookup(@commit_sha)
    ''.tap do |content|
      commit.tree.each do |e|
        if e[:type] == :blob && e[:name] == @filename
          blob = repo.lookup(e[:oid])
          content << blob.content
        end
      end
    end
  end

end

class GitRenderer < Redcarpet::Render::HTML

  GITDOWN_LINE = /^<<(.*)/

  def preprocess(doc)
    doc.gsub!(GITDOWN_LINE) do |markdown|
      Gitdown.new(markdown).process
    end
  end

end

renderer = Redcarpet::Markdown.new(GitRenderer, fenced_code_blocks: true)
markdown = renderer.render(File.read('test.md'))
File.write('preprocessed.md', markdown)
