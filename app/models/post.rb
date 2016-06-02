class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			@post = Post.create(
				title: spreadsheet.row(i)[0],
				content: spreadsheet.row(i)[1]
			)
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
			when '.csv' then Csv.new(file.path, nil, :ignore)
			when '.xls' then Excel.new(file.path, nil, :ignore)
			when '.xlsx' then Excelx.new(file.path, nil, :ignore)
		else
			raise "Unknown file type: #{file.original_filename}"
		end	
	end
end
