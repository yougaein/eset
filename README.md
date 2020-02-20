# ESet

Set/Map with external iterator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ESet'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ESet

## Usage  

    require 'Yk/ESet'
    include Yk

    class Foo
        attr :f  
	    def initialize f  
		    @f = f  
	    end  
    end  

    s = ESet.new do |o|  
	    o.f  
    end  

    s.insert Foo.new(rand)  
    s.insert Foo.new(rand)  
    s.insert Foo.new(rand)  
    s.insert Foo.new(rand)  
    
    ESet.for_each s.begin, s.end do |foo|  
	    p foo.f  
    end  
    
    it = s.begin  
    while it != s.end  
	    p it.item  
	    it.inc  
    end  
    
See [Document page](https://yougaein.github.io/eset/index.html)  


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/eset. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/eset/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the ESet project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/eset/blob/master/CODE_OF_CONDUCT.md).
