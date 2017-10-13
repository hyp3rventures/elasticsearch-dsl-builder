module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class GeoBoundingBox < Query
          def initialize(field)
            @type = :geo_bounding_box
            field(field)
            super()
          end

          def field(field)
            field_valid = field.instance_of?(String) || field.instance_of?(Symbol)
            raise ArgumentError, 'field must be a String or Symbol' unless field_valid
            @field = field.to_sym
            self
          end

          def top_left(lat, lon)
            raise ArgumentError, 'lat must be numeric' unless lat.is_a?(Numeric)
            raise ArgumentError, 'lon must be numeric' unless lon.is_a?(Numeric)
            @top_left = { lat: lat, lon: lon }
            self
          end

          def top_left_geohash(geohash)
            raise ArgumentError, 'geohash must be a String' unless geohash.instance_of?(String)
            @top_left = geohash
            self
          end

          def bottom_right(lat, lon)
            raise ArgumentError, 'lat must be numeric' unless lat.is_a?(Numeric)
            raise ArgumentError, 'lon must be numeric' unless lon.is_a?(Numeric)
            @bottom_right = { lat: lat, lon: lon }
            self
          end

          def bottom_right_geohash(geohash)
            raise ArgumentError, 'geohash must be a String' unless geohash.instance_of?(String)
            @bottom_right = geohash
            self
          end

          def type(type)
            raise ArgumentError, 'type must be a String' unless type.instance_of?(String)
            @geo_type = type
            self
          end

          def to_hash
            raise ArgumentError, 'must have set bounding box' if @top_left.nil? || @bottom_right.nil?
            @query = { @field => { top_left: @top_left, bottom_right: @bottom_right } }
            @query.update(type: @geo_type) if @geo_type
            super
          end
        end
      end
    end
  end
end
