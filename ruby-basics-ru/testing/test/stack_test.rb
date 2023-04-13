# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new %w[one two three]
  end

  def test_push
    four = 'four'
    five = 'five'

    @stack.push! four
    @stack.push! five

    assert { @stack.to_a.size == 5 }
    assert { @stack.to_a.last == five }
    assert { @stack.to_a[-2] == four }
  end

  def test_pop
    @stack.pop!
    assert { @stack.to_a.size == 2 }

    @stack.pop!
    assert { @stack.pop! == 'one' }
    assert { @stack.to_a.empty? }
  end

  def test_clear
    assert { @stack.clear!.to_a.empty? }
  end

  def test_empty
    refute { @stack.empty? }
    @stack = Stack.new
    assert { @stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
