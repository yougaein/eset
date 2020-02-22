# ESet

Set/Map with external iterator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'YkESet'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install YkESet

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

    s.add Foo.new(rand)  
    s.add Foo.new(rand)  
    s.add Foo.new(rand)  
    s.add Foo.new(rand)  
 
    y = rand
    result = s.add Foo.new(y)  
    p result # true
    y = rand
    result = s.add Foo.new(y)  
    p result # false
 
    ESet.for_each s.begin, s.end do |foo|  
	    p foo.f  
    end  

    # use Iterator object

    it, result = s.insert Foo.new(y = rand)
    p result # true
    it, result = s.insert Foo.new(y)
    p result # false
    
    s.erase it
    p s.erased? # true
    begin
        s.erase it # 
    rescue ArgumentError
        p $! 
    end

    it = s.begin  
    while !s.end?
	    p it.item  
	    it.inc  
    end
    begin
        s.item # already reached the end
    rescue RangeError
        p $!
    end    
    
    jt = it
    it.dec
    p it == jt #true
    jt = it.clone
    jt.dec
    p it != jt #true


    
See [Document page](https://yougaein.github.io/eset/index.html)  


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/eset. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/eset/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the ESet project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/eset/blob/master/CODE_OF_CONDUCT.md).
