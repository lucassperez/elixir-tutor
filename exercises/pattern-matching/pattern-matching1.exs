# EXERCISE NOT FINISHED YET

# https://elixirschool.com/en/lessons/basics/pattern_matching#match-operator-0

# In Elixir, the = sign is more similar to mathematics' = sign.
x = 1
# What has to be in the right side for this "equation" to be true?
?? = x

# Create new variables, y and z, with values extracted from the tuple
?? = {1, 2, 3}

# You can uncomment these IO.puts lines to see the values of variables so far
# IO.puts("\n\e[0;32mTutor> First stop:  x = #{x}, y = #{y} and z = #{z}\e[0m")

# Using the variables we have in this point, how to make this match?
list = [1, 2, 3]
?? = list

# IO.puts("\e[0;32mTutor> Second stop: x = #{x}, y = #{y} and z = #{z}\e[0m")

# How to get only that string, without the atom inside the tuple?
# Can you do it creating only ONE more variable? Name it "variable", please (:
?? = {:ok, "Okay!"}

if :variable not in Keyword.keys(binding()) do
  raise "\e[1;31mSomething is not quite right yet\e[0m"
end
