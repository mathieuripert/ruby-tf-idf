# Ruby-Tf-Idf

This gem calculates TF-IDF to find the most relevant words of each document in corpus

TF-IDF is for Term Frequency - Inverse Document Frequency
http://en.wikipedia.org/wiki/Tf%E2%80%93idf

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-tf-idf'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-tf-idf

## Usage

    require 'rubygems'
    require 'ruby-tf-idf'

    corpus = 
    [
    'A big enough hammer can usually fix anything',
    'A bird in the hand is a big mistake .',
    'A bird in the hand is better than one overhead!',
    'A career is a job that takes about 20 more hours a week.',
    'A clean desk is a sign of a cluttered desk drawer.',
    'A cynic smells flowers and looks for the casket.'
    ]

    limit = 3 #restrict to the top 2 relevant words per document
    exclude_stop_words = false

    @t = RubyTfIdf::TfIdf.new(corpus,limit,exclude_stop_words)
    output =  @t.tf_idf


output = [
		{"anything"=>0.7781512503836436, "fix"=>0.7781512503836436, "enough"=>0.7781512503836436}
		{"mistake"=>0.7781512503836436, "bird"=>0.47712125471966244, "in"=>0.47712125471966244}
		{"overhead!"=>0.7781512503836436, "better"=>0.7781512503836436, "one"=>0.7781512503836436}
		{"week"=>0.7781512503836436, "career"=>0.7781512503836436, "hours"=>0.7781512503836436}
		{"desk"=>1.5563025007672873, "drawer"=>0.7781512503836436, "clean"=>0.7781512503836436}
		{"casket"=>0.7781512503836436, "cynic"=>0.7781512503836436, "smells"=>0.7781512503836436}
		]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
