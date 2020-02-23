#!/usr/bin/env ruby

GC::Profiler.enable
#require 'tz/eset'
if File.exists? './ESet.so'
	require './ESet'
else
	require 'Yk/ESet'
end
#require 'tz/debug2' rescue nil

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
p it.erased? # true
begin
	s.erase it #
rescue ArgumentError
	p $! 
end

it = s.begin  
while !it.end?
	p it.item  
	it.inc  
end

begin
	it.item # already reached the end
rescue RangeError
	p $!
end    

jt = it
it.dec
p it == jt #true
jt = it.clone
jt.dec
p it != jt #true


class Item
	attr :time, :f, :cnt
	@@cnt = 0
	def initialize f
		@cnt = @@cnt
		@@cnt += 1
		@time = Time.now
		@f = f
	#	p [self]
	end
	def < arg
	#	p arg
	#	p [arg]
	#	p [self, arg]
		@f < arg.f
	end
end


def main
	s = ESet.new do |o|
	#	p o.f
		o
	end


	p s.insert Item.new(rand)
	p s.insert Item.new(rand)
	p s.insert Item.new(rand)
	p s.insert Item.new(rand)
	p s.insert Item.new(rand)
	p s.insert Item.new(rand)
	ai = s.insert Item.new(r = rand)
	bi = s.insert Item.new(r)
	p ai
	p bi
	p s.size
	toErase = bi[0]
	found = s.find(toErase.item)
	p found == s.end
	p found.item
	found = s.find(Item.new(1))
	p found == s.end
	ESet.for_each s.begin, s.end do |o|
		p [o]
	end

	s.erase toErase
	p s.size
	p toErase.item
	begin
		toErase.inc
	rescue => exception
		p $!		
	end
	p toErase.item
	p s.size
	ESet.for_each s.begin, s.end do |o|
		p [o]
	end

	p ai[0] == bi[0]
	p s.insert Item.new(rand)
	p ai
	p s.begin.item.f
	p s.begin.inc.item.f
	p 200
	aj = s.upper_bound Item.new(0.5);
	ak = s.lower_bound Item.new(0.5);
	p ak
	p ak.item
	it = s.begin
	while it != s.end
		toOut = it.item.f.to_s
		toOut += case it
		when aj
			"\t:upper_bound"
		when ak
			"\t:lower_bound"
		else
			""
		end
		print toOut + "\n"
		it.inc
	end
	p s.size
	ESet.for_each s.begin, s.end do |o|
		p [o.f]
	end

	
	


end

main

class Foo
	attr :f
	def initialize f
		@f = f
	end
end

s = ESet.new
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




