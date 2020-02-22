# namespace Yk
module Yk
# ESets are containers with external iterators that store unique elements following a specific order. For use, require 'Yk/ESet';include Yk;
class ESet
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
    # @overload insert(position, obj)
    #  Insert element with an object using a hint and return new iterator object
    #  @param [ESet::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] obj  Object to be pointed by the inserted elements.
    #  @return [ESet::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.
    # @overload insert(obj)
    #  Insert element and return new iterator object
    #  @param [Object] obj key object to be pointed by the inserted elements.
    #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
    def insert *args
    end
    # @overload add(position, obj)
    #  Insert element with an object using a hint and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [ESet::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] obj  Object to be pointed by the inserted elements.
    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.
    # @overload add(obj)
    #  Insert element with an object and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [Object] obj key object to be pointed by the inserted elements.
    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.
    def add *args
    end
    # @overload erase(position)
    #  Erase an element from the container
    #  @param [ESet::Iterator] position to erase
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when using argument with erased position
    # @overload erase(frist, last)
    #  Erase a range of elements ([first,last)) from the container.
    #  Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    #  @param [ESet::Iterator] first first iterator.
    #  @param [ESet::Iterator] last last iterator.
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when first and last iterators are not from the same container.
    #  @raise RangeError raised when erasing end iterator
    #  @raise ArgumentError raised when use argument with erased position
    def erase *args
    end
    # Searches the container for an element with an object equivalent to the argument.
    # @param [Object] arg to search equivalency.
    # @return [ESet::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when using argument(s) with erased position
    def find arg
    end
    # Searches the container for an element with an object equivalent to the third argument and/or validated with the provided block in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [ESet::Iterator] first first iterator.
    # @param [ESet::Iterator] last last iterator.
    # @param [Object] obj to search equivalency.
    # @yieldparam [Object] obj object argument pointed by an element passed for validation with the block
    # @yieldreturn [Object] validation result from the block
    # @return [ESet::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when neither parameter, obj nor block is provided.
    # @raise ArgumentError raised when using argument(s) with erased position
    # @raise RangeError raised when dereferencing end iterator
    def ESet.find first, last, obj = nil
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [ESet::Iterator] first first iterator.
    # @param [ESet::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when using argument(s) with erased position
    def ESet.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # newly construct a clone iterator
        # @return [ESet::Iterator] newly cloned iterator
        def clone
        end
        # increment the position
        # @return [ESet::Iterator] self
        # @raise RangeError raised when advancing over the end
        # @raise ArgumentError raised when incrementing erased position
        def inc
        end
        # decrement the position
        # @return [ESet::Iterator] self
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
        # @return [ESet::Iterator] self
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
        # dereference the iterator, and returns the pointed object
        # @return [Object] The pointed object
        def item
        end
    end
end
# EMSets are containers with external iterators that store elements following a specific order, and where multiple elements can have equivalent values. For use, require 'Yk/ESet';include Yk;
class EMSet
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
    # @overload insert(position, obj)
    #  Insert element with an object using a hint and return new iterator object
    #  @param [EMSet::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] obj  Object to be pointed by the inserted elements.
    #  @return [EMSet::Iterator] An iterator pointing to either the newly inserted element.
    # @overload insert(obj)
    #  Insert element and return new iterator object
    #  @param [Object] obj key object to be pointed by the inserted elements.
    #  @return [EMSet::Iterator] An iterator pointing to either the newly inserted element.
    def insert *args
    end
    # @overload add(position, obj)
    #  Insert element with an object using a hint and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [EMSet::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] obj  Object to be pointed by the inserted elements.
    #  @return [True] Always return true.
    # @overload add(obj)
    #  Insert element with an object and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [Object] obj key object to be pointed by the inserted elements.
    #  @return [True] Always return true.
    def add *args
    end
    # @overload erase(position)
    #  Erase an element from the container
    #  @param [EMSet::Iterator] position to erase
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when using argument with erased position
    # @overload erase(frist, last)
    #  Erase a range of elements ([first,last)) from the container.
    #  Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    #  @param [EMSet::Iterator] first first iterator.
    #  @param [EMSet::Iterator] last last iterator.
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when first and last iterators are not from the same container.
    #  @raise RangeError raised when erasing end iterator
    #  @raise ArgumentError raised when use argument with erased position
    def erase *args
    end
    # Searches the container for an element with an object equivalent to the argument.
    # @param [Object] arg to search equivalency.
    # @return [EMSet::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when using argument(s) with erased position
    def find arg
    end
    # Searches the container for an element with an object equivalent to the third argument and/or validated with the provided block in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMSet::Iterator] first first iterator.
    # @param [EMSet::Iterator] last last iterator.
    # @param [Object] obj to search equivalency.
    # @yieldparam [Object] obj object argument pointed by an element passed for validation with the block
    # @yieldreturn [Object] validation result from the block
    # @return [EMSet::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when neither parameter, obj nor block is provided.
    # @raise ArgumentError raised when using argument(s) with erased position
    # @raise RangeError raised when dereferencing end iterator
    def EMSet.find first, last, obj = nil
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMSet::Iterator] first first iterator.
    # @param [EMSet::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when using argument(s) with erased position
    def EMSet.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # newly construct a clone iterator
        # @return [EMSet::Iterator] newly cloned iterator
        def clone
        end
        # increment the position
        # @return [EMSet::Iterator] self
        # @raise RangeError raised when advancing over the end
        # @raise ArgumentError raised when incrementing erased position
        def inc
        end
        # decrement the position
        # @return [EMSet::Iterator] self
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
        # @return [EMSet::Iterator] self
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
        # dereference the iterator, and returns the pointed object
        # @return [Object] The pointed object
        def item
        end
    end
end
# EMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order. For use, require 'Yk/ESet';include Yk;
class EMap
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
    #  Insert element with an object using a hint and return new iterator object
    #  @param [EMap::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [EMap::Iterator] An iterator pointing to either the newly inserted element or to the element that already had its equivalent in the container.
    # @overload insert(key, value)
    #  Insert element and return new iterator object
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
    def insert *args
    end
    # @overload add(position, key, value)
    #  Insert element with an object using a hint and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [EMap::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.
    # @overload add(key, value)
    #  Insert element with an object and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [True|False] true if a new element was inserted or false if an equivalent element already existed.
    def add *args
    end
    # @overload insert_or_assign(k, v)
    #  If a key equivalent to 'k' already exists in the container, assigns 'v' to value corresponding to the key. If the key does not exist, inserts the new value as if by insert.
    #  @param [Object] k key object
    #  @param [Object] v value object
    #  @return [Array] An array, with its first member set to an iterator pointing to either the newly inserted element or to the equivalent element already in the set. The second member in the array is set to true if a new element was inserted or false if an equivalent element already existed.
    # @overload insert_or_assign(position, k, v)
    #  Insert element with key and value using a hint
    #  @param [EMap::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] k key object
    #  @param [Object] v value object
    #  @return [EMap::Iterator] Iterator pointing at the element that was inserted or updated
    def insert_or_assign *args
    end
    # @overload erase(position)
    #  Erase an element from the container
    #  @param [EMap::Iterator] position to erase
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when using argument with erased position
    # @overload erase(frist, last)
    #  Erase a range of elements ([first,last)) from the container.
    #  Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    #  @param [EMap::Iterator] first first iterator.
    #  @param [EMap::Iterator] last last iterator.
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when first and last iterators are not from the same container.
    #  @raise RangeError raised when erasing end iterator
    #  @raise ArgumentError raised when use argument with erased position
    def erase *args
    end
    # Searches the container for an element with an object equivalent to the argument.
    # @param [Object] arg to search equivalency.
    # @return [EMap::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when using argument(s) with erased position
    def find arg
    end
    # Searches the container for an element with an object equivalent to the third argument and/or validated with the provided block in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMap::Iterator] first first iterator.
    # @param [EMap::Iterator] last last iterator.
    # @param [Object] obj to search equivalency.
    # @yieldparam [Object] obj object argument pointed by an element passed for validation with the block
    # @yieldreturn [Object] validation result from the block
    # @return [EMap::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when neither parameter, obj nor block is provided.
    # @raise ArgumentError raised when using argument(s) with erased position
    # @raise RangeError raised when dereferencing end iterator
    def EMap.find first, last, obj = nil
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMap::Iterator] first first iterator.
    # @param [EMap::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when using argument(s) with erased position
    def EMap.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # newly construct a clone iterator
        # @return [EMap::Iterator] newly cloned iterator
        def clone
        end
        # increment the position
        # @return [EMap::Iterator] self
        # @raise RangeError raised when advancing over the end
        # @raise ArgumentError raised when incrementing erased position
        def inc
        end
        # decrement the position
        # @return [EMap::Iterator] self
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
        # @return [EMap::Iterator] self
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
        # dereference the iterator, and returns the key object and the value object
        # @return [Array] Array of the pointed key object and value object
        def item
        end
    end
end
# EMMaps are associative containers with external iterators that store elements formed by a combination of a key and a value, following a specific order, and where multiple elements can have equivalent keys. For use, 'Yk/ESet';include Yk;
class EMMap
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
    #  Insert element with an object using a hint and return new iterator object
    #  @param [EMMap::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [EMMap::Iterator] An iterator pointing to either the newly inserted element.
    # @overload insert(key, value)
    #  Insert element and return new iterator object
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [EMMap::Iterator] An iterator pointing to either the newly inserted element.
    def insert *args
    end
    # @overload add(position, key, value)
    #  Insert element with an object using a hint and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [EMMap::Iterator] position  Hint for the position where the element can be inserted.
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [True] Always return true.
    # @overload add(key, value)
    #  Insert element with an object and return true if a new element was inserted or false if an equivalent element already existed. Do not return iterator object. More efficient if you do not need inserted position (removed by GC). 
    #  @param [Object] key key object to be pointed by the inserted elements.
    #  @param [Object] value value object to be pointed by the inserted elements.
    #  @return [True] Always return true.
    def add *args
    end
    # @overload erase(position)
    #  Erase an element from the container
    #  @param [EMMap::Iterator] position to erase
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when using argument with erased position
    # @overload erase(frist, last)
    #  Erase a range of elements ([first,last)) from the container.
    #  Iterators specifying a range within the set container to be removed: [first,last). i.e., the range includes all the elements between first and last, including the element pointed by first but not the one pointed by last.
    #  @param [EMMap::Iterator] first first iterator.
    #  @param [EMMap::Iterator] last last iterator.
    #  @raise ArgumentError raised when an argument is not a compatible iterator.
    #  @raise ArgumentError raised when first and last iterators are not from the same container.
    #  @raise RangeError raised when erasing end iterator
    #  @raise ArgumentError raised when use argument with erased position
    def erase *args
    end
    # Searches the container for an element with an object equivalent to the argument.
    # @param [Object] arg to search equivalency.
    # @return [EMMap::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when using argument(s) with erased position
    def find arg
    end
    # Searches the container for an element with an object equivalent to the third argument and/or validated with the provided block in a range of elements ([first,last)), 'obj' and returns an iterator to it if found, otherwise it returns an iterator to .
    # @param [EMMap::Iterator] first first iterator.
    # @param [EMMap::Iterator] last last iterator.
    # @param [Object] obj to search equivalency.
    # @yieldparam [Object] obj object argument pointed by an element passed for validation with the block
    # @yieldreturn [Object] validation result from the block
    # @return [EMMap::Iterator] iterator pointing the element with equivalent object.
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when neither parameter, obj nor block is provided.
    # @raise ArgumentError raised when using argument(s) with erased position
    # @raise RangeError raised when dereferencing end iterator
    def EMMap.find first, last, obj = nil
    end
    # Applies given block to each of the elements in the range [first,last).
    # @param [EMMap::Iterator] first first iterator.
    # @param [EMMap::Iterator] last last iterator.
    # @yieldparam [Object] obj object in an element
    # @raise ArgumentError raised when an argument is not a compatible iterator.
    # @raise ArgumentError raised when first and last iterators are not from the same container.
    # @raise ArgumentError raised when using argument(s) with erased position
    def EMMap.for_each first, last
    end
    # Iterator class, pointing an element in container
    class Iterator
        # newly construct a clone iterator
        # @return [EMMap::Iterator] newly cloned iterator
        def clone
        end
        # increment the position
        # @return [EMMap::Iterator] self
        # @raise RangeError raised when advancing over the end
        # @raise ArgumentError raised when incrementing erased position
        def inc
        end
        # decrement the position
        # @return [EMMap::Iterator] self
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
        # @return [EMMap::Iterator] self
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
        # dereference the iterator, and returns the key object and the value object
        # @return [Array] Array of the pointed key object and value object
        def item
        end
    end
end

end # module Yk
