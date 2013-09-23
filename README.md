"Time is what we want most, but what we use worst."
--------------

[![Code Climate](https://codeclimate.com/github/benSlaughter/allotment.png)](https://codeclimate.com/github/benSlaughter/allotment)
[![Build Status](https://travis-ci.org/benSlaughter/allotment.png?branch=master)](https://travis-ci.org/benSlaughter/allotment)
[![Dependency Status](https://gemnasium.com/benSlaughter/allotment.png)](https://gemnasium.com/benSlaughter/allotment)
[![Coverage Status](https://coveralls.io/repos/benSlaughter/allotment/badge.png?branch=master)](https://coveralls.io/r/benSlaughter/allotment)
[![Gem Version](https://badge.fury.io/rb/allotment.png)](http://badge.fury.io/rb/allotment)

---------------

Allotment is a performance time recording gem.
It makes recording performance simple, while still being powerful and flexible.

## Setup

Allotment has been tested with Ruby 1.9.2 and later.
To install:

```bash
gem install allotment
```

## Using Allotment with Cucumber

If you are using Cucumber you can record each scenario.
Add this line into your env.rb file:

```ruby
require 'allotment/cucumber'
```

## Using Allotment

Require Allotment at the start of your code:

```ruby
require 'allotment'
```

### Recording a Block

Recording a block of code could not be simpler.

```ruby
Allotment.record('my_recording') { # code here }
```
```ruby
Allotment.record('my_recording') do
  # code here
end
```

When an event has been completed the performance timing is returned by the method.

```ruby
performance = Allotment.record { # code here }
```
```ruby
performance = Allotment.record do
  # code here
end
```

### Record point to point

Sometime you may want to record performance of more than just a block.
Allotment can do that too.

```ruby
Allotment.start 'my_recording'
# code here
Allotment.stop 'my_recording'
```

When stop is called the performance timing is returned by the method.

```ruby
performance = Allotment.stop 'my_recording'
```

When start recording is called the timing stopwatch is returned by the method.

```ruby
stopwatch = Allotment.start 'my_recording'
```

_More on [stopwatches](#allotment-stopwatches)_

**If a recording name does not exists, then a NameError is raised.**

### Accessing performance results

Allotment stores all the performance recordings as and when they happen.
If multiple recording of the same event exist they are stored in an array.
Allotment also patches Array with an average function.

```ruby
hash = Allotment.results
```
```ruby
array = Allotment.results["my_recording"]
```
```ruby
result = Allotment.results["my_recording"].first
```
```ruby
result = Allotment.results["my_recording"].average

```

### Allotment Stopwatches

TODO

