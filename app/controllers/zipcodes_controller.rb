class ZipcodesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def find
    zip = Zipcode.find_by_zipcode(params[:zipcode])
    if zip.present?
      tz = ActiveSupport::TimeZone[zip.utc_offset]
      render json: {
        status: 200,
        tz_name: tz.tzinfo.name,
        zipcode: zip.slice('city', 'dst', 'lat', 'lng', 'state', 'utc_offset', 'zipcode')
      }
    else
      render status: 404, json: {
        errors: 'Zipcode not found'
      }
    end
  end
end
