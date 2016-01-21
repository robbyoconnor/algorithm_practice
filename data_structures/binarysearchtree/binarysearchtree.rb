# coding: utf-8

# A binary search tree
class BinarySearchTreeNode
  attr_accessor :value
  attr_reader :left, :right

  def initialize(value)
    @value = value
    @left  = nil
    @right = nil
  end

  def insert(v)
    case value <=> v
    when 1 then insert_left(v)
    when -1 then insert_right(v)
    when 0 then false # the value is already present
    end
  end

  def in_order(node = self)
    return if node.nil?
    in_order(node.left) if node.left
    print "#{node.value} "
    in_order(node.right) if node.right
  end

  def pre_order(node = self)
    return if node.nil?
    print node.value.to_s + ' '
    pre_order(node.left)
    pre_order(node.right)
  end

  def post_order(node = self)
    return if node.nil?
    post_order(node.left)
    post_order(node.right)
    print node.value.to_s + ' '
  end

  def level_order(node = self)
    q = []
    q.unshift(node)
    until q.empty?
      node = q.pop
      print node.value.to_s + ' '
      q.unshift(node.left)  unless node.left.nil?
      q.unshift(node.right) unless node.right.nil?
    end
    print "\n"
  end

  def find_smallest(node = self)
    return node if node.e.left.nil?
    find_smallest node.left
  end

  def find_largest(node = self)
    return node if node.right.nil?
    find_largest node.right
  end

  def recursive_second_smallest(node = self)
    current = node
    left_leaf = current.left &&
                current.left.left.nil? &&
                current.left.right.nil?
    return find_smallest(current.left) if current.right && current.left.nil?
    return current.value if left_leaf
    recursive_second_smallest(current.left)
  end

  def iterative_second_smallest
    current = self
    while current
      left_leaf = current.left &&
                  current.left.left.nil? &&
                  current.left.right.nil?
      return find_smallest(current.left) if current.right && current.left.nil?
      return current.value if left_leaf
      current = current.left
    end
  end

  def recursive_second_largest(node = self)
    current = node
    right_leaf = current.right &&
                 current.right.left.nil? &&
                 current.right.right.nil?
    return find_largest(current.left) if current.left && current.right.nil?
    return current.value if right_leaf
    recursive_second_largest(current.right)
  end

  def iterative_find_second_largest
    current = self
    while current
      right_leaf = current.right &&
                   current.right.left.nil? &&
                   current.right.right.nil?
      return find_largest(current.left) if current.left && current.right.nil?
      return current.value if right_leaf
      current = current.right
    end
  end

  def height(node = self)
    return 0 unless node
    1 + max(height(node.left), height(node.right))
  end

  def inspect
    "{#{value}=>#{left.inspect} | #{right.inspect}}"
  end

  def to_s
    inspect.to_s
  end

  private

  def max(a, b)
    a > b ? a : b
  end

  def insert_left(v)
    if left
      left.insert(v)
    else
      @left = BinarySearchTreeNode.new(v)
    end
  end

  def insert_right(v)
    if right
      right.insert(v)
    else
      @right = BinarySearchTreeNode.new(v)
    end
  end
end
t = BinarySearchTreeNode.new(20)

t.insert(24)
t.insert(19)
t.insert(10)
t.insert(30)
t.insert(35)

puts t
print "Tree height: #{t.height}\n"

print 'In order traversal: '
t.in_order
print "\n"
print 'Pre-order traversal: '
t.pre_order
print "\n"
print 'Post-order traversal: '
t.post_order
print "\n"
print 'Level-order traversal: '
t.level_order

print "Second largest (iterative): #{t.iterative_find_second_largest}\n"
print "Second Largest (recursive): #{t.recursive_second_largest}\n"
print "Second Smallest (iterative): #{t.iterative_second_smallest}\n"
print "Second Smallest (recursive): #{t.recursive_second_smallest}\n"
