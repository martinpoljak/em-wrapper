# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/object"
require "object-proxy"
require "eventmachine"

##
# Core EventMachine module.
# @see http://rubyeventmachine.com/
#

module EM
  
    ##
    # Wraps objects callbacks to EventMachine next ticks,
    # so multiplexes them.
    #
    
    module Wrapper
      
        ##
        # Creates new wrapper.
        #
        # @param [Object] object  wrapped object
        # @return [Object]  another object of the same class linked to original object
        #
        
        def self.new(object)
            op = OP::catch(object)
            op.method_call do |name, args, block|
                op.wrapped.send(name, *args) do |result|
                    EM::next_tick do
                        result = [result] if not result.array?
                        block.call(*result)
                    end
                end
            end
            
            return op
        end
        
    end
end

=begin
w = EM::Wrapper::new("xxx")
p w
p w.kind_of? String
=end