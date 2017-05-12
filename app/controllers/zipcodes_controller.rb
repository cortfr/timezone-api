class ZipcodesController < ApplicationController
  def find
    zip = Zipcode.find_by_zipcode(params[:zipcode])
    if zip.present?
      tz = ActiveSupport::TimeZone[zip.timezone]
      render json: {
        status: 200,
        tz_name: tz.tzinfo.name,
        zipcode: zip.to_json
      }
    else
      render json: {
        status: 404,
        errors: 'Zipcode not found'
      }
    end    
  end
end
