defmodule Practice.Factor do

  def factor(x) do
    inspect(factorize(x, 2, []))
  end

  defp factorize(x, factor, factor_list) when x < factor do
    factor_list
  end

  defp factorize(x, factor, factor_list) do
    if rem(x, factor) == 0 do
      factor_list = [factor | factorize(div(x, factor), factor, factor_list)]
    else
      factorize(x, factor + 1, factor_list)
    end
  end

end
