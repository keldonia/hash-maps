class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    interm_hash = 2 ** 256
    self.each_with_index do |el, i|
      interm_hash = (el.hash + i.hash) ^ interm_hash
    end
    if self.empty?
      interm_hash ^ interm_hash
    end
    interm_hash
  end
end

class String
  def hash
    self.split('').map { |char| char.ord }.hash
  end
end

# class Hash
#   def hash
#   end
# end
