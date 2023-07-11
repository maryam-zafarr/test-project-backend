# frozen_string_literal: true

require 'csv'
require 'English'

class CsvImportService
  attr_reader :file, :errors

  def initialize(file)
    @file = file
    @errors = []
  end

  def import_csv
    puts @file
    CSV.foreach(file, headers: true) do |row|
      product = Product.new(name: row['product_id'], category: extract_category(row['product_id']), unit: row['unit'],
                            date: row['date'], weight: row['weight'])
      unless product.valid?
        errors << { row_number: $INPUT_LINE_NUMBER, errors: product.errors.full_messages }
        next
      end
      product.save
    rescue StandardError => e
      errors << { row_number: $INPUT_LINE_NUMBER, error: e.message }
    end
    errors.empty?
  rescue CSV::MalformedCSVError
    errors << { error: 'Invalid CSV file format' }
    false
  end

  private

  def extract_category(product_id)
    product_id[0..2] if product_id
  end
end
