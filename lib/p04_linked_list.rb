require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil? && @tail.nil?

    # !(@head && @tail)
  end

  def get(key)
    self.each do |link|
      # debugger
      return link.val if link.key == key
    end

    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end

    false
  end

  def insert(key, val)
    link = Link.new(key, val)
    if @head.nil?
      @head, @tail = link, link
    else
      link.prev = @tail
      link.prev.next = link
      @tail = link
    end
  end

  def remove(key)
    target_link = nil

    self.each do |link|
      if link.key == key
        target_link = link
        break
      end
    end

    if target_link == @head
      @head = target_link.next
      @head.prev = nil
      target_link.next = nil
    elsif target_link == @tail
      @tail = target_link.prev
      @tail.next = nil
      target_link.prev = nil
    else
      target_link.prev.next = target_link.next.prev
      target_link.next.prev = target_link.prev.next
    end
  end

  def each(&prc)
    link = @head
    until link.nil?
      prc.call(link)
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
