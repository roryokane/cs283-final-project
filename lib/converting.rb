def convert_bc_to_c(better_c)
	dumb_implementation(better_c)
end

def test_implementation(better_c)
	better_c.chomp.reverse
end

def dumb_implementation(better_c)
	lines = better_c.split("\n")
	# #split("\n") ignores ending newline, so
	#  I must keep track of it myself
	has_ending_newline = better_c.end_with?("\n")
	
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
	indent_level = 0
	original_lines = lines.dup
	original_lines.each_with_index do |line, index|
		line_indent_level = (line.match(/\t*/)[0]).size
		if line_indent_level > indent_level
			lines[index - 1] = lines[index - 1] + " {"
		elsif line_indent_level < indent_level
			indents = "\t" * line_indent_level
			lines = lines.insert(index, indents + "}")
		end
		indent_level = line_indent_level
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
	
	result_text = lines.join("\n")
	if has_ending_newline
		result_text += "\n"
	end
	return result_text
end

def parsing_implementation(better_c)
	# not written yet
end
