defmodule Practice.Calc do

  def parse_float(text) do
    if is_binary(text) do
      {num, _} = Float.parse(text)
      num
    else
      text
    end
  end

  @operators %{
    "+" => 1,
    "-" => 1,
    "*" => 2,
    "/" => 2
  }

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> to_postfix([], [])
    |> prefix_evaluate([])

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end


  defp to_postfix([], stack, result) do
    # the base cases
    if length(stack) != 0 do
      [head | stack] = stack
      result = result ++ [head]
      to_postfix([], stack, result)
    else
      result
    end
  end


  defp to_postfix(expr, stack, result) do
    [head | expr] = expr
    if @operators[head] == nil do
      # current item is numeric
      to_postfix(expr, stack, result ++ [head])
    else
      # current item is an operator
      if length(stack) == 0 do
        to_postfix(expr, [head | stack], result)
      else
        case @operators[head] do
          1 ->
            # the operator is + and -
            to_postfix(expr, [head], result ++ stack)
          2 ->
            # the operator is * and /
            case @operators[hd(stack)] do
              1 -> to_postfix(expr, [head | stack], result)
              2 -> to_postfix(expr, [head], result ++ stack)
          end
        end
      end
    end
  end


  defp prefix_evaluate([], stack) do
    # base case
    if length(stack) == 0 do
      0
    else
      [head | stack] = stack
      parse_float(head)
    end
  end

  defp prefix_evaluate(expr, stack) do
    [head | expr] = expr
    if @operators[head] == nil do
      prefix_evaluate(expr, [head | stack])
    else
      # current char is an operator
      [val1 | stack] = stack
      prefix_evaluate(expr, [calculate(val1, hd(stack), head) | tl(stack)])
    end
  end

  defp calculate(val1, val2, op) do
    val1 = parse_float(val1)
    val2 = parse_float(val2)
    case op do
      "+" -> val2 + val1
      "-" -> val2 - val1
      "*" -> val2 * val1
      "/" -> val2 / val1
      _ -> 0
    end
  end
end
