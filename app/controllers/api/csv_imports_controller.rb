# frozen_string_literal: true

class Api::CsvImportsController < ApplicationController
  def create
    file = csv_import_params[:file]
    return render json: { error: 'No file uploaded.' }, status: :unprocessable_entity if file == 'undefined'

    csv_service = CsvImportService.new(file)
    if csv_service.import_csv
      render json: { message: 'CSV imported successfully.' }
    else
      render json: { error: csv_service.errors }, status: :unprocessable_entity
    end
  end

  private

  def csv_import_params
    params.permit(:file)
  end
end
