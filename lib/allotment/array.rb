# Ruby Array
class Array
  # If an array is all numbers
  # This displayes the mean average
  #
  def average
    inject(:+).to_f / size
  end
end