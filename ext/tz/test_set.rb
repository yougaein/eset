#!/usr/bin/env ruby

GC::Profiler.enable
require 'tz/eset'
#require 'tz/debug2'


class Item
	attr :time, :f, :cnt
	@@cnt = 0
	def initialize f
		@cnt = @@cnt
		@@cnt += 1
		@time = Time.now
		@f = f
		p [self]
	end
	def < arg
		p arg
		p [arg]
		p [self, arg]
		@f < arg.f
	end
end


def main
	s = EMSet.new do |o|
		p o.f
		o
	end


	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)
	s.insert Item.new(rand)

	p s.begin.item.f
	p s.begin.inc.item.f
	p 200
	EMSet.for_each s.begin, s.end do |item|
		p item.f
	end
end


main


