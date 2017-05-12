namespace :zipcodes do

  task :import => :environment do
    require 'csv'

    puts "Initializing..."
    working_dir = File.join(TimezoneApi::Application.config.root.to_s, '/tmp/')
    csv_data = File.read(File.join(working_dir, 'zipcode.csv'))

    puts "Importing..."
    csv = CSV.parse(csv_data, :headers => true, :header_converters => :symbol)
    i = 0
    csv.each do |row|
      Zipcode.create(zipcode: row[:zip], city: row[:city], state: row[:state],
        lat: row[:latitude], lng: row[:longitude], utc_offset: row[:timezone], dst: !row[:dst].to_i.zero?
      )
      i = i + 1
    end

    puts "Done; #{i} zipcodes imported"
  end

end
