EventMachine Wrapper
====================

**em-wrapper** wraps objects callbacks to [EventMachine][8] next ticks using
`EM::next_tick`, so allows transparent multiplexing of objects which 
aren't multiplexable by default.

It provides proxied class, so returned class is kind of the same class
as wrapped class, with different `#object_id` only. Also standard returns
work as expected and as is usuall. 
  
See some example:

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
            p value                  # 2. will be run in next EM tick, will print :foo out
        }
    end    
    

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][9] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.


Copyright
---------

Copyright &copy; 2011 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[8]: http://rubyeventmachine.com/
[9]: http://github.com/martinkozak/em-wrapper/issues
[10]: http://www.martinkozak.net/
