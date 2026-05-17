module Enumerable
  # Your code goes here
  def my_all?
    self.my_each do |elem|
      return false unless yield(elem)
    end

    true
  end

  def my_any?
    self.my_each do |elem|
      return true if yield(elem)
    end

    false
  end

  def my_none?
    self.my_each do |elem|
      return false if yield(elem)
    end

    true
  end

  def my_count
    return self.size unless block_given?

    count = 0
    self.my_each do |elem|
      count += 1 if yield(elem)
    end

    count
  end

  def my_select
    return self.to_enum unless block_given?

    new_arr = []
    self.my_each do |elem|
      new_arr << elem if yield(elem)
    end

    new_arr
  end

  def my_each_with_index
    unless block_given?
      result = []
      index = 0
      self.my_each do |elem|
        result += [[elem, index]]
        index += 1
      end
      return result.to_enum
    end

    index = 0
    while index < self.size
      yield(self[index], index)
      index += 1
    end

    self
  end

  def my_inject(init_value)
    value = init_value
    self.my_each do |elem|
      value = yield(elem, value)
    end

    value
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    new_arr = []
    self.my_each do |elem|
      new_arr << yield(elem)
    end

    new_arr
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    if block_given?
      index = 0
      while index < self.size
        yield self[index]
        index += 1
      end
    else
      return self.to_enum
    end

    self
  end
end
