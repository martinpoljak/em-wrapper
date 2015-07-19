EventMachine Wrapper
====================

**em-wrapper** wraps objects callbacks to [EventMachine][8] next ticks using
`EM::next_tick`, so allows transparent multiplexing of objects which 
aren't multiplexable by default.

It provides proxied class, so returned class is kind of the same class
as wrapped class, with different `#object_id` only. Also standard returns
work as expected and as is usuall. 
  
See some example:

```ruby
require "em-wrapper"
require "eventmachine"

class Foo
    def foo
        yield :foo
        return :bar
    end
end

wrapped = EM::Wrapper::new(Foo)::new
EM::run do
    p wrapped.foo { |value|      # 1. will print :bar out
        p value                  # 2. will be run in next EM 
                                 #    tick, will print :foo out
    }
end    
```

Also object wrapping is supported. In that case, simply give object instance instead of class object to the constructor. Wrapped object instance will be returned.

Copyright
---------

Copyright &copy; 2011 &ndash; 2015 [Martin Poljak][10]. See `LICENSE.txt` for
further details.

[8]: http://rubyeventmachine.com/
[9]: http://github.com/martinkozak/em-wrapper/issues
[10]: http://www.martinpoljak.net/
