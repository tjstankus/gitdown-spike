require 'rugged'

repo = Rugged::Repository.new('.')

commit_shas = [
  'c7d453b4d736faed3be9d62cab48f87de2b4012e',
  'ecedda21c2d9611d198e6de3280f1a65f4fefce3'
]

file_name = 'text1.txt'

commit_shas.each do |sha|
  commit = repo.lookup(sha)
  commit.tree.each do |e|
    if e[:type] == :blob && e[:name] == file_name
      puts "\n========\n\nThe rugged object:"
      puts e.inspect

      blob = repo.lookup(e[:oid])
      puts "\n#{file_name} contents at commit #{sha}:\n"
      puts blob.content
    end
  end
end

