# With statement thing
values = [1, 2, 3, 4, 5, 6]
mean = with count = Enum.count(values),
             sum   = Enum.sum(values)
        do
          sum/count
        end

IO.puts mean