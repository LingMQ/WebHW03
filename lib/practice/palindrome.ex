defmodule Practice.Palindrome do

  # Return true if the given string is indeed a palindrome.
  def palindrome(x) do
    re = String.reverse(x)
    if re === x do
      true
    else
      false
    end
  end

end