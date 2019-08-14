class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max+1,false)


  end

  def insert(num)
    raise "Out of bounds" if num > store.length-1 || num < 0
    store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num > store.length-1 || num < 0
    store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if num > store.length-1 || num < 0
    store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].each do |n|
      return true if num == n 
    end
    false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet

  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if self.include?(num)
    self.count = count + 1
    resize! if count >= num_buckets 
      
    self << num 
  end

  def remove(num)
    return unless self.include?(num)

    self.count = count - 1
    self[num].delete(num)
  end

  def include?(num)
    self[num].each do |n|
        return true if n == num 
    end 
    false 
  end

  def <<(num)
     self[num].push(num)
  end


  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new (num_buckets * 2) {Array.new}
    temp.each do |buckets|
      buckets.each do |ele|
        self << (ele)
      end
    end
  end
end
