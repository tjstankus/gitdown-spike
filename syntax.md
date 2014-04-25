Syntax Ideas
============

Syntax ideas for what goes inside fenced code blocks for defining what to pull
in from a file at a specific commit sha. Most specifically, I'm undecided about
how to capture the options part, the thing that looks like a hash inside the
parentheses in the first example.

Idea 1
------

My original idea. It sorta looks like an options hash, which is okay I guess.
It's not the simplest to parse, but probably not too bad. I'm sorta meh on this
syntax. It will lead to lon

```
<<[Listing 2](file: 'hello.rb', sha: 'af68c6261b14feccdd354b5c1055dcc733cad1e3', lines: '1,6-9')
```

Idea 2
------

JSON format. Looks like shit. It's a pain in the ass to type. But it's really
simple to parse with `JSON.parse`.

```
<<[Listing 2]({ "file": "hello.rb", "sha": "af68c6261b14feccdd354b5c1055dcc733cad1e3", "lines": "1,6-9" })
```

Idea 3
------

I haven't tried parsing this syntax yet, but it's growing on me. It looks
Markdown-ish, although I'm not sure that's a great idea inside a fenced code
block. The shorter lines are more readable.

```
<<[Listing 2]
  - file: hello.rb
  - sha: af68c6261b14feccdd354b5c1055dcc733cad1e3
  - lines: 1,6-9
```
