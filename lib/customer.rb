require 'time'
class Customer
  attr_reader :id,
              :name,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:created_at].to_s)
  end
end
