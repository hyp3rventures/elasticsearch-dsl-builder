require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::GeoBoundingBox do
  it 'should fail if field not a String or Symbol' do
    expect { Queries::GeoBoundingBox.new(123) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new(nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').field({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if top_left arguments not Numeric' do
    expect { Queries::GeoBoundingBox.new('field').top_left({}, nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').top_left(1, nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').top_left({}, 1) }.to raise_error(ArgumentError)
  end

  it 'should fail if bottom_right arguments not Numeric' do
    expect { Queries::GeoBoundingBox.new('field').bottom_right({}, nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').bottom_right(1, nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').bottom_right({}, 1) }.to raise_error(ArgumentError)
  end

  it 'should fail if top_left_geohash argument not a String' do
    expect { Queries::GeoBoundingBox.new('field').top_left_geohash({}) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').top_left_geohash(nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').top_left_geohash(1) }.to raise_error(ArgumentError)
  end

  it 'should fail if bottom_right_geohash argument not a String' do
    expect { Queries::GeoBoundingBox.new('field').bottom_right_geohash({}) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').bottom_right_geohash(nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').bottom_right_geohash(1) }.to raise_error(ArgumentError)
  end

  it 'should fail if type argument not a String' do
    expect { Queries::GeoBoundingBox.new('field').type({}) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').type(nil) }.to raise_error(ArgumentError)
    expect { Queries::GeoBoundingBox.new('field').type(1) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    geo_bounding_box = Queries::GeoBoundingBox.new(:field_a).
      top_left(1, 2).bottom_right(3, 4).type('indexed')
    expect(geo_bounding_box.to_hash).to eq(
      geo_bounding_box: { field_a: { top_left: { lat: 1, lon: 2 }, bottom_right: { lat: 3, lon: 4 } }, type: 'indexed' }
    )

    geo_bounding_box = Queries::GeoBoundingBox.new(:field_a).
      top_left_geohash('dr5r9ydj2y73').bottom_right_geohash('dr5r9ydj2y73').type('indexed')
    expect(geo_bounding_box.to_hash).to eq(
      geo_bounding_box: { field_a: { top_left: 'dr5r9ydj2y73', bottom_right: 'dr5r9ydj2y73' }, type: 'indexed' }
    )
  end
end
