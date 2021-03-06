module Enumerable
	def my_each(&block)
		if block.nil?
			return self
		end
		last_index = self.length - 1
		for i in 0..last_index
			yield(self[i])
		end		
	end

	def my_each_with_index(&block)
		if block.nil?
			return self
		end

		last_index = self.length - 1
		for i in 0..last_index
			yield(self[i],i)
		end
	end

	def my_select(&block)
		if block.nil?
			return self
		end

		outarr = []
		self.my_each do |item| 
			outarr << item if yield(item)
		end
		outarr
	end

	def my_all?(&block)
		result = true
		if block.nil?
			self.my_each do |item|
				result = false if item.nil? or !item
			end
		else
		    self.my_each do |item|
			    result = false if !yield(item)
		    end
		end
		result
	end

	def my_any?(&block)
		result = false
		if block.nil?
			self.my_each do |item|
				result = true if !item.nil? and item
			end
		else
	 	    self.my_each do |item|
			    result = true if yield(item)
		    end
	    end
		result
	end

	def my_none?(&block)
		result = !(self.my_any?(&block))
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

	def my_map(proc=nil, &block)
		# if proc and block are defined, applies block to
		# the result of proc
		# If proc is nil, just applies block
		# If proc is defined, ignore block
		outarr = []
		self.my_each do |item|
			if !proc.nil?
				outarr << proc.call(item)
			else
				if !block.nil?
					outarr << block.call(item)
				end
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
