# EXERCISE NOT FINISHED YET
# In Elixir, the = sign is more similar to mathematics' = sign.
x = 1
# What has to be in the right side for this "equation" to be true?
1 = x

# Create new variables, y and z, with values extracted from the tuple
# y = nil # You should delete or comment this line and create y and z both together with x
# z = nil # Same story here!
{x, y, z} = {1, 2, 3}

if x != 1 or y != 2 or z != 3 do
  raise "Not quite! Don't forget that the order matters (:"
end

IO.puts("\n\e[0;32mTutor> First stop: x = #{x}, y = #{y} and z = #{z}\e[0m")

# Using the variables we have in this point, how to make this match?
list = [1, 2, 3]
[x, y, z] = list

IO.puts("\e[0;32mTutor> Second stop: x = #{x}, y = #{y} and z = #{z}\e[0m")

# How to get only that string, without the atom inside the tuple?
# Can you do it creating only ONE more variable? Name it "variable", please (:
?? = {:ok, "Okay!"}

# IO.puts("\e[0;32mTutor> Last \"variable\": #{variable}\e[0m\n")

# https://elixirschool.com/en/lessons/basics/pattern_matching#match-operator-0

# Gabarito
# # In Elixir, the = sign is more similar to mathematics = sign.
# x = 1
# # What has to be in the right side for this "equation" to be true?
# 1 = x

# # Create new variables, y and z, with values extracted from the tuple
# # y = nil # You should delete this line and create y and z both together with x
# # z = nil # Same story here!
# {x, y, z} = {1, 2, 3}

# if x != 1 or y != 2 or z != 3 do
#   raise "Not quite! Don't forget that the order matters (:"
# end

# IO.puts("First stop: x = #{x}, y = #{y} and z = #{z}")

# # Using the variables we have in this point, how to make these match?
# list = [1, 2, 3]
# [x, y, z] = list

# IO.puts("Second stop: x = #{x}, y = #{y} and z = #{z}")

# # How to get only that string, without the atom inside the tuple?
# # Can you do it creating only ONE more variable? Name it "variable", please (:
# {:ok, variable} = {:ok, "Okay!"}

# IO.puts("Last \"variable\": #{variable}\n")

# # https://elixirschool.com/en/lessons/basics/pattern_matching#match-operator-0
