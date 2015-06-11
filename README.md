# tictactoe-cli.rb
[![Travis CI](https://travis-ci.org/demonh3x/tictactoe-cli.rb.svg)](https://travis-ci.org/demonh3x/tictactoe-cli.rb)
[![Code Climate](https://codeclimate.com/github/demonh3x/tictactoe-cli.rb/badges/gpa.svg)](https://codeclimate.com/github/demonh3x/tictactoe-cli.rb)
[![Test Coverage](https://codeclimate.com/github/demonh3x/tictactoe-cli.rb/badges/coverage.svg)](https://codeclimate.com/github/demonh3x/tictactoe-cli.rb/coverage)

## Description

This is a [command line interface][cli] for tictactoe-core.rb

[cli]: http://en.wikipedia.org/wiki/Command-line_interface

## Dependencies

##### Execution
* Ruby, from v2.0.0 to 2.2.0 (other versions might work too)
* [tictactoe-core.rb][core] v0.1.2

[core]: https://github.com/demonh3x/tictactoe-core.rb

##### Testing
* [RSpec][rspec] 3.1.0
* [Codeclimate Test Reporter][climate] (For CI environment)

[rspec]: http://rspec.info/
[climate]: https://github.com/codeclimate/ruby-test-reporter

##### Others
* [Bundler][bundler] (To manage dependencies)
* [Rake][rake] (To run preconfigured tasks)

[bundler]: http://bundler.io/
[rake]: https://github.com/ruby/rake

## Setup

##### Install dependencies
`bundle install`

##### Run tests
`rake`

##### Run game
`rake run` or `bin/tictactoe_cli`

## Rake tasks
run `rake -T` to see all available tasks

## Preview
```
What will be the size of the board?
3 = 3x3 board
4 = 4x4 board
3
Who will play?
1 = Human VS Human
2 = Human VS Computer
3 = Computer VS Human
4 = Computer VS Computer
2
+---+---+---+
| 0 | 1 | 2 |
+---+---+---+
| 3 | 4 | 5 |
+---+---+---+
| 6 | 7 | 8 |
+---+---+---+
Your turn! Where do you want to move?
0
+---+---+---+
| x | 1 | 2 |
+---+---+---+
| 3 | 4 | 5 |
+---+---+---+
| 6 | 7 | 8 |
+---+---+---+
+---+---+---+
| x | 1 | 2 |
+---+---+---+
| 3 | o | 5 |
+---+---+---+
| 6 | 7 | 8 |
+---+---+---+
Your turn! Where do you want to move?
```
