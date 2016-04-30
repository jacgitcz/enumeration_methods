module Enumerable
	def my_each
		last_index = self.length - 1
		for i in 0..last_index
			yield(self[i])
		end		
	end

	def my_each_with_index
		last_index = self.length - 1
		for i in 0..last_index
			yield(self[i],i)
		end
	end

	def my_select
		outarr = []
		self.my_each do |item| 
			outarr << item if yield(item)
		end
		outarr
	end

	def my_all?
		result = true
		self.my_each do |item|
			result = false if !yield(item)
		end
		result
	end

	def my_any?
		result = false
		self.my_each do |item|
			result = true if yield(item)
		end
		result
	end

	def my_none?
		result = false
		self.my_each do |item|
			result = true if yield(item)
		end
		!result
	end

	def my_count(value=nil, &block)
		countval = 0
		self.my_each do |item|
			if block.nil?
				if value.nil?
					countval += 1
				else
					countval += 1 if item == value
				end
			else
				countval += 1 if block.call(item)
			end
		end
		countval
	end

	def my_map(proc, &block)
		# if proc and block are defined, applies block to
		# the result of proc
		outarr = []
		self.my_each do |item|
			if block.nil?
				outarr << proc.call(item)
			elsif !proc.nil?
				val1 = proc.call(item)
				outarr << block.call(val1)
			end
		end
		outarr
	end

	def my_inject(init=nil,op=nil,&block)
		acc = init.nil? ? self[0] : init

		self.my_each_with_index do |item, i|
			if i == 0 and init.nil?
				next
			else
				if block.nil?
					acc = acc.send(op, item)
				else
					acc = block.call(acc,item)
				end
			end
		end
		acc
	end
end

def multiply_els(num_array)
	result = num_array.my_inject(1,:*)
end