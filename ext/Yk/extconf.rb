require 'mkmf'

have_library("stdc++")
$CXXFLAGS += " -O3 -std=c++1y "
create_makefile("Yk/ESet") 
