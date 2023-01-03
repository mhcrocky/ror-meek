class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << 'is not a valid url.' if value !~ URI::regexp
  end

end


