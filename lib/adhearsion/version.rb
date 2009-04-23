module Adhearsion #:nodoc:
  module VERSION #:nodoc:
    MAJOR = 0 unless defined? MAJOR
    MINOR = 8 unless defined? MINOR
    TINY  = 3 unless defined? TINY
    BRANCH = 'cnu' unless defined? BRANCH
    STRING = [MAJOR, MINOR, TINY, BRANCH].join('.') unless defined? STRING
  end
end
