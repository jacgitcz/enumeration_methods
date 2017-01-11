require_relative "../enum_methods"

describe Enumerable do
	describe "#my_each" do
		it "passes each element to the block" do
			result = []
			[1,2,3].my_each do |x|
				result << 2*x
			end
			expect(result).to eq [2,4,6]
		end
		it 'returns the original collection if there is no block' do
			result = [4, 5, 6].my_each
			expect(result).to eq [4, 5, 6]
		end
		it 'does nothing if there are no elements' do
			result = 'No change'
			[].my_each do |x|
				result = 'changed'
			end
			expect(result).to eq 'No change'
		end
	end

	describe '#my_each_with_index' do
		it 'passes each element and its index to the block' do
			result = []
			[17,11,23].my_each_with_index do |x, i|
				result << i
				result << 3 * x
			end
			expect(result).to eq [0, 51, 1, 33, 2, 69]
		end
		it 'returns the original collection if there is no block' do
			result = [10, 9, 8].my_each
			expect(result).to eq [10, 9, 8]
		end
		it 'does nothing if there are no elements' do
			result = 'No change'
			[].my_each do |x|
				result = 'changed'
			end
			expect(result).to eq 'No change'
		end
	end

	describe '#my_select' do
		it 'returns an array containing elements for which block is true' do
			result = [1,3,5,7,9,11,12].my_select {|x| x % 3 == 0 }
			expect(result).to eq [3, 9, 12]
		end
		it 'returns the original collection if there is no block' do
			result = [1,3,5,7,9,11,12].my_select
			expect(result).to eq [1,3,5,7,9,11,12]
		end
	end

	describe '#my_all?' do
		it 'returns true if block is true for all elements' do
			result = [2, 4, 6, 8, 10, 12, 14].my_all? {|x| x % 2 == 0}
			expect(result).to eq true
		end
		it 'returns false if block is not true for all elements' do
			result = [2, 4, 6, 8, 10, 13, 14].my_all? {|x| x % 2 == 0}
			expect(result).to eq false
		end
		it 'returns true if no block and no elements are false' do
			result = [2, 4, 6, 8, 10, true, 14].my_all?
			expect(result).to eq true
		end
		it 'returns false if no block and 1 or more elements are false' do
		    result = [2, 4, nil, 8, 10, false, 14].my_all?
		    expect(result).to eq false
		end
	end

	describe '#my_any?' do
		it 'returns true if block returns true for any element' do
			result = [2, 4, 6, 9, 10, 12, 14].my_any? {|x| x % 5 == 0 }
			expect(result).to eq true
		end
		it 'returns false if block returns true for no element' do
			result = [2, 4, 6, 9, 11, 12, 14].my_any? {|x| x % 5 == 0 }
			expect(result).to eq false
		end
		it 'returns true if no block and at least one element is truthy' do
			result = [false, nil, true, false, false, 1].my_any?
			expect(result).to eq true
		end
		it 'returns false if no block and no elements are truthy' do
			result = [false, nil, false, false, nil, false].my_any?
			expect(result).to eq false
		end
	end

	describe '#my_none?' do
		it 'returns true if block returns false for all elements' do
			result = [2, 4, 6, 9, 10, 12, 15].my_none? {|x| x % 7 == 0 }
			expect(result).to eq true
		end
		it 'returns false if block returns true for any element' do
			result = [2, 4, 7, 9, 10, 12, 14].my_none? {|x| x % 7 == 0 }
			expect(result).to eq false
		end
		it 'returns true if no block and all elements are falsey' do
			result = [false, nil, false, false, nil, false].my_none?
			expect(result).to eq true
		end
		it 'returns false if no block and at least one element is truthy' do
			result = [false, nil, 1, false, true, false].my_none?
			expect(result).to eq false
		end
	end

	describe '#my_count' do
		it 'counts the number of items in the collection' do
			number = [1, 8, 7, 23, 3, 99].my_count
			expect(number).to eq 6
		end
		it 'counts the number of items equal to its argument' do
			number = [1, 8, 7, 23, 3, 99, 23, 11, 23, 12].my_count(23)
			expect(number).to eq 3			
		end
		it 'counts the number of elements for which block returns true' do
			number = [1, 8, 7, 23, 3, 4, 99, 23, 11, 32, 23, 12].my_count {|x| x % 2 != 0 }
			expect(number).to eq 8			
		end
		it 'returns zero for an empty collection' do
			number = [].my_count
			expect(number).to eq 0
		end
	end

	describe '#my_map' do
		it 'applies the block to each element and returns the resulting array' do
			result = [1, 8, 7, 23, 3, 99, 23, 11, 23, 12].my_map {|x| x * 7}
			expect(result).to eq [7, 56, 49, 161, 21, 693, 161, 77, 161, 84]
		end
	end

	describe '#my_inject' do
		it 'applies a binary op between the elements, starting with the initial value' do
			result = [1, 2, 3, 4, 5].my_inject(7, :+)
			expect(result).to eq 22
		end
		it 'accumulates values using code in the supplied block' do
			result = [1, 2, 3, 4, 5].my_inject(2) {|m, x| m + 3 * x }
			expect(result).to eq 47
		end
	end
end
