# Returns true if n is abundant, false otherwise.
# n is an abundant number if the sum of its proper divisors is greater than n.
function abundant(n)
	# The smallest abundant number is 12.
	n >= 12 || return false

	# Initialize the sum of the divisors to 1 since 1 is always a divisor.
	s = 1
	sqrtn = Int(trunc(sqrt(n)))
	# Check divisibility by numbers from 2 to sqrt(n).
	for i in 2:sqrtn
		q, r = divrem(n, i)
		if r == 0
			# Add i and n/i (= q).
			s += i + q
		end
	end
	# If n is a perfect square we added sqrtn twice in previous for loop.
	if sqrtn * sqrtn == n
		s -= sqrtn
	end

	return s > n
end

# We look for numbers that are NOT writeable as sum of two abundant nubmers.
# All numbers greater than 28123 are writeable as sum of two abundant numbers.
# Since the smallest abundant number is 12, we are intersted in all sums of
# two abundant numbers from 12 to 28123-12, since greater numbers, added to
# another abundant number, gives a number greater than 28123.
ab = Integer[]
for n in 12:28123-12
	if abundant(n)
		push!(ab, n)
	end
end

# Initialize sums set with all numbers from 1 to 28123.
sums = Set(1:28123)
abcopy = copy(ab)
# Loop through abundant numbers array.
for n in ab
	# Remove from sums all the numbers got adding n to every abundant number.
	setdiff!(sums, abcopy .+ n)

	# NOT REQUIRED
	# Remove n from the list of abundant numbers since we already removed from
	# sums all values corresponding to adding n.
	setdiff!(abcopy, n)
end

# Print the result
println(sum(sums))