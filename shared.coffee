# shared code
random_range = (lower, upper) ->
  Math.floor(Math.random() * (upper - lower + 1)) + lower
