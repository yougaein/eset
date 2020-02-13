#!/usr/bin/env ruby

fw = File.open "for_yard_product.rb", "w"
%W{ESet EMSet EMap EMMap}.each do |c|
    fw.write <<END
class #{c}
#{
    case(c)
    when "ESet"
        "   # ESets are containers with external iterators that store unique elements following a specific order.\n"
    when "EMSet"
        "   # EMSets are containers with external iterators that store elements following a specific order, and where multiple elements can have equivalent values.\n"
    when "EMap"
        "   # EMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order.\n"
    when "EMMap"
        "   # EMMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order, and where multiple elements can have equivalent keys.\n"
    end
}
    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
#{
    case(c)
    when "ESet", "EMSet"
        "   # @yieldparam [Object] obj object pointed by an element.\n"
    else
        "   # @yieldparam [Object] key object pointed by an element.\n"
    end
}
    # @yieldreturn [Object] should be comparable with method, '<'.
    def initialize
    end
    # @return [#{c}::Iterator] Return iterator to beginning
    def begin
    end
    # @return [#{c}::Iterator] Return iterator to end
    def end
    end
    # @return [Integer] Return container size
    def size
    end
    # Clear content
    def clear
    end
    # @return [#{c}::Iterator] Return iterator to upper bound
    def upper_bound
    end
    # @return [#{c}::Iterator] Return iterator to lower bound
    def lower_bound 
    end
#{
    case(c)
    when "ESet", "EMSet"
        "   # @overload insert(position, obj)\n"
    when "EMap", "EMMap"
        "   # @overload insert(position, key, value)\n"
    end
}
    #  Insert element with an object using a hint
    #  @param [#{c}::Iterator] position  Hint for the position where the element can be inserted.
#{
    case(c)
    when "ESet", "EMSet"
        "   #  @param [Object] obj  Object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "   #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "   #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}
#{
    case(c)
    when "ESet", "EMap"
        "   #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.\n"
    else
        "   #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element.\n"
    end
}
#{
    case(c)
    when "ESet", "EMSet"
        "   # @overload insert(obj)\n"
    when "EMap", "EMMap"
        "   # @overload insert(key, value)\n"
    end
}
    #  Insert element with an object
#{
    case(c)
    when "ESet", "EMSet"
        "   #  @param [Object] obj key object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "   #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "   #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}
#{
    case(c)
    when "ESet", "EMap"
        "   #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.\n"
    else
        "   #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element.\n"
    end
}   def insert *args
    end
    # Removes from the set container a range of elements ([first,last)).
    # Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    # @param [#{c}::Iterator] first first iterator.
    # @param [#{c}::Iterator] last last iterator.
    def erase first, last
    end
    # Searches the container for an element with an object equivalent to the third argument in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [#{c}::Iterator] first first iterator.
    # @param [#{c}::Iterator] last last iterator.
    # @param obj Object to search equivalent.
    # @return [#{c}::Iterator] iterator pointing the element with equivalent object.
    def #{c}.find first, last, obj
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [#{c}::Iterator] first first iterator.
    # @param [#{c}::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    def #{c}.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # increment the position
        # @return [#{c}::Iterator] self
        def inc
        end
        # decrement the position
        # @return [#{c}::Iterator] self
        def dec
        end
        # compare for equivalence 
        # @return [TRUE|FALSE] true or false
        def ==
        end
        # compare for unequivalence 
        # @return [TRUE|FALSE] true or false
        def !=
        end
#{
    case(c)
    when "ESet", "EMSet"
        "   # dereference the iterator, and returns the pointed object\n" +
        "   # @return [Object] The pointed object\n"
    when "EMap", "EMMap"
        "   # dereference the iterator, and returns the key object and the value object\n" +
        "   # @return [Array] Array of the pointed key object and value object\n"
    end
}
        def item
        end
    end
end
END
end

fw.close

system "yardoc for_yard_product.rb -o ../../docs"
