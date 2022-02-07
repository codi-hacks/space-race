-- -*- mode: lua; -*- vim: set syntax=lua:

-- https://github.com/mpeterv/luacheck/blob/master/src/luacheck/builtin_standards.lua
std = 'luajit'

-- Ignore libs as we aren't accountable for those
exclude_files = { 'lib/*.*' }

-- Ignore all global variable references to love
files['**/*.lua'] = {
  globals = {
    'love'
  }
}
-- Ignore busted spec file globals
local busted_globals = {
  'after_each',
  'assert',
  'before_each',
  'describe',
  'match',
  'mock',
  'stub',
  'spy',
  'it'
}
files['*.spec.lua'] = {
  globals = busted_globals
}
files['**/*.spec.lua'] = {
  globals = busted_globals
}

-- List of allowed globals
globals = {}

-- false, don't allow something to be defined (??)
allow_defined = false

-- false, don't allow something to be defined on top (??)
allow_defined_top = false

-- true, enable color on command line
color = true

-- true, enable error codes on command line
-- http://luacheck.readthedocs.org/en/stable/warnings.html
codes = true

-- true, don't allow globals
global = true

-- 1, concurrent checks (requires lualanes)
-- https://github.com/LuaLanes/lanes
jobs = 1

-- true, don't allow variables to be shadowed
redefined = true

-- maximum characters per line allower before throw an error
max_line_length = 120

-- true, don't allow use of the deprecated module function
module = true

-- true, don't allow unused variable
unused = true

-- true, don't allow unused arguments
unused_args = true

-- true, don't allow unused secondary variables
unused_secondaries = true
