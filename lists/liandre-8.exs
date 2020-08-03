# ListsAndRecursion-8
defmodule Liandre8 do
  def get_totals(rates, orders) when is_list(rates) and is_list(orders) do
    for [{:id, i}, {:ship_to, state}, {:net_amount, amount}] <- orders do
      [{:id, i}, {:ship_to, state}, {:net_amount, amount},
       {:total_amount, (1 + Keyword.get(rates, state, 0)) * amount}]
    end
  end

  # Function to parse and process a file of taxes with get_totals function
  def calc_order_totals(path) when is_binary(path) do

    {:ok, file} = File.open(path, [:read])

    [:id, :ship_to, :net_amount] = String.split(IO.read(file, :line), ",") \
      |> Enum.map(&String.trim/1) \
      |> Enum.map(&String.to_atom/1)

    orders = for line <- IO.stream(file,:line) do
        [id,state,amount] = String.split(line, ",") |> Enum.map(&String.trim/1)
        [
          {:id,         String.to_integer(id)},
          {:ship_to,    String.to_atom(String.trim_leading(state, ":"))},
          {:net_amount, String.to_float(amount)}
        ]
      end

    get_totals([NC: 0.075,TX: 0.08], orders)
  end
end


# tax_rates = [NC: 0.075,TX: 0.08]
# orders = [
  # [id: 123,ship_to: :NC,net_amount: 100.00],
  # [id: 124,ship_to: :OK,net_amount: 35.50],
  # [id: 125,ship_to: :TX,net_amount: 24.00],
  # [id: 126,ship_to: :TX,net_amount: 44.80],
  # [id: 127,ship_to: :NC,net_amount: 25.00],
  # [id: 128,ship_to: :MA,net_amount: 10.00],
  # [id: 129,ship_to: :CA,net_amount: 102.00],
  # [id: 130,ship_to: :NC,net_amount: 50.00]
# ]