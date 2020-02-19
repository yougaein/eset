#!/usr/bin/env ruby

GC::Profiler.enable
#require 'tz/eset'
if File.exists? './eset.so'
	require './eset'
else
	require 'Yk/eset'
end
#require 'tz/debug2'

include Yk

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
	EMSet.for_each s.begin, s.end do |item|
		p [item.f]
	end
end


main


