def convert_bc_to_c(better_c)
	dumb_implementation(better_c)
end

def test_implementation(better_c)
	better_c.chomp.reverse
end

def dumb_implementation(better_c)
	lines = better_c.split("\n", -1)
	# negative second parameter indicates to keep trailing blank lines
	
	# add parens around conditionals
	original_lines = lines.dup
	original_lines.each_with_index do |line, index|
		paren_keywords = ["if", "while", "for"]
		paren_keywords.each do |keyword|
			if line.match(/\s*#{keyword}/)
				lines[index] = lines[index].sub("#{keyword} ", keyword + " (")
				lines[index] += ")"
			end
		end
	end
	
	# add {} from indents
	# only works with tab indents right now
	prev_indent_level = 0
	original_lines = lines.dup
	original_lines.each_with_index do |line, index|
		this_indent_level = (line.match(/\t*/)[0]).size
		if this_indent_level > prev_indent_level
			indent_increase = this_indent_level - prev_indent_level
			# in actual programs, indent should never double-increase,
			#  but handling it seems better than ignoring it
			indent_increase.times do
				lines[index - 1] = lines[index - 1] + " {"
			end
		elsif this_indent_level < prev_indent_level
			closing_brace_lines = []
			(prev_indent_level - 1).step(this_indent_level, -1).each do |closing_indent_level|
				indents = "\t" * closing_indent_level
				closing_brace_lines.push(indents + "}")
			end
			lines = lines.insert(index, *closing_brace_lines)
		end
		prev_indent_level = this_indent_level
	end
	
	# add semicolons
	lines = lines.map do |line|
		line_needs_semicolon = true
		
		starting_cancels = ['#']
		ending_cancels = %w[{ } ; , + - \\]
		regex_cancels = [/^\s*$/, /^\s*\/\//]
		
		cancels_and_test_methods = {
			starting_cancels => :start_with?,
			ending_cancels => :end_with?,
			regex_cancels => :match,
		}
		cancels_and_test_methods.each do |cancels, test_method|
			cancels.each do |cancel|
				if line.send(test_method, cancel)
					line_needs_semicolon = false
				end
			end
		end
		
		if line_needs_semicolon
			line + ";"
		else
			line
		end
	end
	
	return lines.join("\n")
end

def parsing_implementation(better_c)
	# not written yet
end
