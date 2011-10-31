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
        # @param [Object, Class] cls  wrapped object or class
        # @return [Object, Class]  another object or class of the same class linked to original object
        #
        
        def self.new(cls)
            op = OP::catch(cls)

            worker = Proc::new do |object|
                object.method_call do |name, args, block|
                    object.wrapped.send(name, *args) do |result|
                        if not block.nil?
                            EM::next_tick do
                                result = [result] if not result.array?
                                block.call(*result)
                            end
                        end
                    end
                end
            end
                        
            if cls.kind_of? Class
                op.instance_created do |object|
                    worker.call(object)
                end
            else
                worker.call(op)
            end

            return op
        end
        
    end
end

