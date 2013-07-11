class Array
  def average
    inject(:+).to_f / size
  end
end