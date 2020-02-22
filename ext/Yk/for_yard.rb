#!/usr/bin/env ruby

fw = File.open "for_yard_product.rb", "w"
fw.write <<EPRE
# namespace Yk
module Yk
EPRE
%W{ESet EMSet EMap EMMap}.each do |c|
    fw.write <<END
#{
    case(c)
    when "ESet"
        "# ESets are containers with external iterators that store unique elements following a specific order. For use, require 'Yk/ESet';include Yk;\n"
    when "EMSet"
        "# EMSets are containers with external iterators that store elements following a specific order, and where multiple elements can have equivalent values. For use, require 'Yk/ESet';include Yk;\n"
    when "EMap"
        "# EMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order. For use, require 'Yk/ESet';include Yk;\n"
    when "EMMap"
        "# EMMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order, and where multiple elements can have equivalent keys. For use, 'Yk/ESet';include Yk;\n"
    end
}class #{c}
    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
#{
    case(c)
    when "ESet", "EMSet"
        "    # @yieldparam [Object] obj object pointed by an element.\n"
    else
        "    # @yieldparam [Object] key object pointed by an element.\n"
    end
}    # @yieldreturn [Object] should be comparable with method, '<'.
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
        "    # @overload insert(position, obj)\n"
    when "EMap", "EMMap"
        "    # @overload insert(position, key, value)\n"
    end
}    #  Insert element with an object using a hint and return new iterator object
    #  @param [#{c}::Iterator] position  Hint for the position where the element can be inserted.
#{
    case(c)
    when "ESet", "EMSet"
        "    #  @param [Object] obj  Object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "    #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "    #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}#{
    case(c)
    when "ESet", "EMap"
        "    #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.\n"
    else
        "    #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element.\n"
    end
}#{
    case(c)
    when "ESet", "EMSet"
        "    # @overload insert(obj)\n"
    when "EMap", "EMMap"
        "    # @overload insert(key, value)\n"
    end
}    #  Insert element and return new iterator object
#{
    case(c)
    when "ESet", "EMSet"
        "    #  @param [Object] obj key object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "    #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "    #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}#{
    case(c)
    when "ESet", "EMap"
        "    #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.\n"
    else
        "    #  @return [#{c}::Iterator] An iterator pointing to either the newly inserted element.\n"
    end
}    def insert *args
    end
#{
    case(c)
    when "ESet", "EMSet"
        "    # @overload add(position, obj)\n"
    when "EMap", "EMMap"
        "    # @overload add(position, key, value)\n"
    end
}    #  Insert element with an object using a hint and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [#{c}::Iterator] position  Hint for the position where the element can be inserted.
#{
    case(c)
    when "ESet", "EMSet"
        "    #  @param [Object] obj  Object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "    #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "    #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}#{
    case(c)
    when "ESet", "EMap"
        "    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.\n"
    else
        "    #  @return [True] Always return true.\n"
    end
}#{
    case(c)
    when "ESet", "EMSet"
        "    # @overload add(obj)\n"
    when "EMap", "EMMap"
        "    # @overload add(key, value)\n"
    end
}    #  Insert element with an object and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
#{
    case(c)
    when "ESet", "EMSet"
        "    #  @param [Object] obj key object to be pointed by the inserted elements.\n"
    when "EMap", "EMMap"
        "    #  @param [Object] key key object to be pointed by the inserted elements.\n" +
        "    #  @param [Object] value value object to be pointed by the inserted elements.\n"
    end
}#{
    case(c)
    when "ESet", "EMap"
        "    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.\n"
    else
        "    #  @return [True] Always return true.\n"
    end
}    def add *args
    end
END
    fw.flush
    if c == "EMap"
        fw.write <<FOR_EMAP
    # @overload insert_or_assign(k, v)
    #  If a key equivalent to 'k' already exists in the container, assigns 'v' to value corresponding to the key. If the key does not exist, inserts the new value as if by insert.
    #  @param [Object] k key object
    #  @param [Object] v value object
    #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
    # @overload insert_or_assign(position, k, v)
    #  Insert element with key and value using a hint
    #  @param [#{c}::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] k key object
    #  @param [Object] v value object
    #  @return [#{c}::Iterator] Iterator pointing at the element that was inserted or updated
    def insert_or_assign *args
    end
FOR_EMAP
    end
    fw.flush
    fw.write <<END2
    # @overload erase(position)
    #  Erase an element from the container
    #  @param [#{c}::Iterator] position to erase
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when using argument with erased position
    # @overload erase(frist, last)
    #  Erase a range of elements ([first,last)) from the container.
    #  Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    #  @param [#{c}::Iterator] first first iterator.
    #  @param [#{c}::Iterator] last last iterator.
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when first and last iterators are not from the same container.
    #  @raise RangeError raised when erasing end iterator
    #  @raise ArgumentError raised when use argument with erased position
    def erase *args
    end
    # Searches the container for an element with an object equivalent to the argument.
    # @param [Object] arg to search equivalency.
    # @return [#{c}::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when using argument(s) with erased position
    def find arg
    end
    # Searches the container for an element with an object equivalent to the third argument and/or validated with the provided block in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [#{c}::Iterator] first first iterator.
    # @param [#{c}::Iterator] last last iterator.
    # @param [Object] obj to search equivalency.
    # @yieldparam [Object] obj object argument pointed by an element passed for validation with the block
    # @yieldreturn [Object] validation result from the block
    # @return [#{c}::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when neither parameter, obj nor block is provided.
    # @raise ArgumentError raised when using argument(s) with erased position
    # @raise RangeError raised when dereferencing end iterator
    def #{c}.find first, last, obj = nil
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [#{c}::Iterator] first first iterator.
    # @param [#{c}::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when using argument(s) with erased position
    def #{c}.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # newly construct a clone iterator
        # @return [#{c}::Iterator] newly cloned iterator
        def clone
        end
        # increment the position
        # @return [#{c}::Iterator] self
        # @raise RangeError raised when advancing over the end
        # @raise ArgumentError raised when incrementing erased position
        def inc
        end
        # decrement the position
        # @return [#{c}::Iterator] self
        # @raise RangeError raised when rewinding over the beginning
        # @raise ArgumentError raised when decrementing erased position
        def dec
        end
        # returns true if the iterator is already reached the end
        # @return [True|False] true|false
        # @raise ArgumentError raised when the pstion of the iterator is already erased
        def isEnd?
        end
        # returns true if iterator position is already erased
        # @return [True|False] true|false
        def isErased?
        end
        # assign the positions of argument
        # @return [#{c}::Iterator] self
        # @raise ArgumentError raised in case right operand is not compatible
        def assign arg
        end
        # compare for equivalence of positions
        # @return true or false
        # @raise ArgumentError raised in case right operand is not compatible
        def == arg
        end
        # compare for unequivalence of positions
        # @return true or false
        # @raise ArgumentError raised in case right operand is not compatible
        def !=
        end
#{
    case(c)
    when "ESet", "EMSet"
        "        # dereference the iterator, and returns the pointed object\n" +
        "        # @return [Object] The pointed object\n"
    when "EMap", "EMMap"
        "        # dereference the iterator, and returns the key object and the value object\n" +
        "        # @return [Array] Array of the pointed key object and value object\n"
    end
}        def item
        end
    end
end
END2
    fw.flush
end
fw.write "\nend # module Yk\n"
fw.close

system "yardoc for_yard_product.rb -o ../../docs"
