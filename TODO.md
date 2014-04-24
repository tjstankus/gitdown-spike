TODO
====

- [ ] Configure the repository location

- [ ] Process hash-like string into a hash itself. String -> Hash ->

- [ ] Files within a directory, down the git commit tree. Use the walker in
  rugged?

- [ ] Does redcarpet have a hook for fenced code blocks? If so, should we use
  it?

- [ ] How to handle code listing titles? Ideally:

  - Internally hyperlinked
  - Visually differentiated, but this could be a CSS/output thing slightly out
    of scope for an extension whose main purpose is to parse out snippets from a
    repository. Perhaps it should just create headings that are have a
    documented html attribute.

- [ ] Handle exceptional conditions

  - sha not found, etc. Actually rugged probably handles this, just let it
    bubble back up.


