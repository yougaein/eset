class ESet
   # ESets are containers with external iterators that store unique elements following a specific order.

    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
   # @yieldparam [Object] obj object pointed by an element.

    # @yieldreturn [Object] should be comparable with method, '<'.
    def initialize
    end
    # @return [ESet::Iterator] Return iterator to beginning
    def begin
    end
    # @return [ESet::Iterator] Return iterator to end
    def end
    end
    # @return [Integer] Return container size
    def size
    end
    # Clear content
    def clear
    end
    # @return [ESet::Iterator] Return iterator to upper bound
    def upper_bound
    end
    # @return [ESet::Iterator] Return iterator to lower bound
    def lower_bound 
    end
   # @overload insert(position, object)

    #  Insert element with an object using a hint
    #  @param [ESet::Iterator] position  Hint for the position where the element can be inserted.
   #  @return [ESet::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.
   # @overload insert(object)
    #  Insert element with an object
    #  @param [Object] obj  Object to be pointed by the inserted elements.
   #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
   def insert position, obj = nil
    end
    # Removes from the set container a range of elements ([first,last)).
    # Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    # @param [ESet::Iterator] first first iterator.
    # @param [ESet::Iterator] last last iterator.
    def erase first, last
    end
    # Searches the container for an element with an object equivalent to the third argument in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [ESet::Iterator] first first iterator.
    # @param [ESet::Iterator] last last iterator.
    # @param obj Object to search equivalent.
    def self.find first, last, obj
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [ESet::Iterator] first first iterator.
    # @param [ESet::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    def self.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # increment the position
        # @return [ESet::Iterator] self
        def inc
        end
        # decrement the position
        # @return [ESet::Iterator] self
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
   # dereference the iterator, and returns the pointed object
   # @return [Object] The pointed object

        def item
        end
    end
end
class EMSet
   # EMSets are containers with external iterators that store elements following a specific order, and where multiple elements can have equivalent values.

    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
   # @yieldparam [Object] obj object pointed by an element.

    # @yieldreturn [Object] should be comparable with method, '<'.
    def initialize
    end
    # @return [EMSet::Iterator] Return iterator to beginning
    def begin
    end
    # @return [EMSet::Iterator] Return iterator to end
    def end
    end
    # @return [Integer] Return container size
    def size
    end
    # Clear content
    def clear
    end
    # @return [EMSet::Iterator] Return iterator to upper bound
    def upper_bound
    end
    # @return [EMSet::Iterator] Return iterator to lower bound
    def lower_bound 
    end
   # @overload insert(position, object)

    #  Insert element with an object using a hint
    #  @param [EMSet::Iterator] position  Hint for the position where the element can be inserted.
   #  @return [EMSet::Iterator] An iterator pointing to either the newly inserted element.
   # @overload insert(object)
    #  Insert element with an object
    #  @param [Object] obj  Object to be pointed by the inserted elements.
   #  @return [EMSet::Iterator] An iterator pointing to either the newly inserted element.
   def insert position, obj = nil
    end
    # Removes from the set container a range of elements ([first,last)).
    # Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    # @param [EMSet::Iterator] first first iterator.
    # @param [EMSet::Iterator] last last iterator.
    def erase first, last
    end
    # Searches the container for an element with an object equivalent to the third argument in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMSet::Iterator] first first iterator.
    # @param [EMSet::Iterator] last last iterator.
    # @param obj Object to search equivalent.
    def self.find first, last, obj
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMSet::Iterator] first first iterator.
    # @param [EMSet::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    def self.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # increment the position
        # @return [EMSet::Iterator] self
        def inc
        end
        # decrement the position
        # @return [EMSet::Iterator] self
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
   # dereference the iterator, and returns the pointed object
   # @return [Object] The pointed object

        def item
        end
    end
end
class EMap
   # EMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order.

    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
   # @yieldparam [Object] key object pointed by an element.

    # @yieldreturn [Object] should be comparable with method, '<'.
    def initialize
    end
    # @return [EMap::Iterator] Return iterator to beginning
    def begin
    end
    # @return [EMap::Iterator] Return iterator to end
    def end
    end
    # @return [Integer] Return container size
    def size
    end
    # Clear content
    def clear
    end
    # @return [EMap::Iterator] Return iterator to upper bound
    def upper_bound
    end
    # @return [EMap::Iterator] Return iterator to lower bound
    def lower_bound 
    end
   # @overload insert(position, key, value)

    #  Insert element with an object using a hint
    #  @param [EMap::Iterator] position  Hint for the position where the element can be inserted.
   #  @return [EMap::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.
   # @overload insert(object)
    #  Insert element with an object
    #  @param [Object] obj  Object to be pointed by the inserted elements.
   #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
   def insert position, obj = nil
    end
    # Removes from the set container a range of elements ([first,last)).
    # Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    # @param [EMap::Iterator] first first iterator.
    # @param [EMap::Iterator] last last iterator.
    def erase first, last
    end
    # Searches the container for an element with an object equivalent to the third argument in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMap::Iterator] first first iterator.
    # @param [EMap::Iterator] last last iterator.
    # @param obj Object to search equivalent.
    def self.find first, last, obj
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMap::Iterator] first first iterator.
    # @param [EMap::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    def self.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # increment the position
        # @return [EMap::Iterator] self
        def inc
        end
        # decrement the position
        # @return [EMap::Iterator] self
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
   # dereference the iterator, and returns the key object and the value object
   # @return [Array] Array of the pointed key object and value object

        def item
        end
    end
end
class EMMap
   # EMMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order, and where multiple elements can have equivalent keys.

    # initlialize with a block which returns comparing basis like Enumerable::sort_by, however using <, not <=>.
   # @yieldparam [Object] key object pointed by an element.

    # @yieldreturn [Object] should be comparable with method, '<'.
    def initialize
    end
    # @return [EMMap::Iterator] Return iterator to beginning
    def begin
    end
    # @return [EMMap::Iterator] Return iterator to end
    def end
    end
    # @return [Integer] Return container size
    def size
    end
    # Clear content
    def clear
    end
    # @return [EMMap::Iterator] Return iterator to upper bound
    def upper_bound
    end
    # @return [EMMap::Iterator] Return iterator to lower bound
    def lower_bound 
    end
   # @overload insert(position, key, value)

    #  Insert element with an object using a hint
    #  @param [EMMap::Iterator] position  Hint for the position where the element can be inserted.
   #  @return [EMMap::Iterator] An iterator pointing to either the newly inserted element.
   # @overload insert(object)
    #  Insert element with an object
    #  @param [Object] obj  Object to be pointed by the inserted elements.
   #  @return [EMMap::Iterator] An iterator pointing to either the newly inserted element.
   def insert position, obj = nil
    end
    # Removes from the set container a range of elements ([first,last)).
    # Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    # @param [EMMap::Iterator] first first iterator.
    # @param [EMMap::Iterator] last last iterator.
    def erase first, last
    end
    # Searches the container for an element with an object equivalent to the third argument in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMMap::Iterator] first first iterator.
    # @param [EMMap::Iterator] last last iterator.
    # @param obj Object to search equivalent.
    def self.find first, last, obj
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMMap::Iterator] first first iterator.
    # @param [EMMap::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    def self.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # increment the position
        # @return [EMMap::Iterator] self
        def inc
        end
        # decrement the position
        # @return [EMMap::Iterator] self
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
   # dereference the iterator, and returns the key object and the value object
   # @return [Array] Array of the pointed key object and value object

        def item
        end
    end
end
