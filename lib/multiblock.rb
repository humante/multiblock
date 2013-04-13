require "blankslate"

class Multiblock < BlankSlate
  def initialize(&default)
    default ||= lambda { |*args| nil }

    @blocks = Hash.new(default)
  end

  def method_missing(name, *args, &blk)
    return call(name, *args) unless block_given?
    @blocks[name.to_s] = blk
  end

  def call(name, *args)
    @blocks[name.to_s].call(*args)
  end
end
