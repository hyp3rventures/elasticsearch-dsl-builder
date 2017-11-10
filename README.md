[![Gem Version](https://badge.fury.io/rb/elasticsearch-dsl-builder.svg)](https://badge.fury.io/rb/elasticsearch-dsl-builder)
[![CircleCI](https://circleci.com/gh/hyp3rventures/elasticsearch-dsl-builder.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/hyp3rventures/elasticsearch-dsl-builder)
[![codecov](https://codecov.io/gh/hyp3rventures/elasticsearch-dsl-builder/branch/master/graph/badge.svg)](https://codecov.io/gh/hyp3rventures/elasticsearch-dsl-builder)

# Elasticsearch DSL Builder
Library utilizing builder pattern providing a Ruby API for the [Elasticsearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html).

Compatible with Ruby 2.3.2 or higher and Elasticsearch 5.0 and higher

## Requirements
* None 🙌 - Lightweight DSL

## Installation
Install the package from [Rubygems](https://rubygems.org):
```ruby
gem install elasticsearch-dsl
```

## Overview
This library helps to build your Elasticsearch requests using the Builder pattern. The objects can then be translated to Hashes and JSON to be used to communicate with Elasticsearch via REST requests.

Currently still in development and adding new features on a rolling basis. If there is a filter or aggregation missing, please submit an issue or submit a pull request with the component as well as a fully covered spec.

The features currently supported are:

* [Queries](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-queries.html)
* [Filters](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-filters.html)
* [Aggregations](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-aggregations.html)
* [Sorting](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-request-sort.html)
* [Pagination](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-request-from-size.html)

An example request is below (Uses the `[Elasticsearch::Client](https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-api)` bundled with the `elasticsearch-api` gem to send the request):
```ruby
search = Search.new.include_fields(%w(first_name last_name))
search.query(
        Queries::Bool.new.
          filter(Queries::Terms.new('field', %w(value1 value2))).
          should(Queries::Exists.new('required_field')).
          should(Queries::Range.new('range_field').gt(0).lt(10)).
          minimum_should_match(1)
      ).
        size(20).
        search_after(%w(cursor_a cursor_b)).
        sort_by('start_date', 'desc').
        aggregation(:teammates, Aggregations::Stats.new.field('teammate_count'))
        
response = ElasticsearchClient.new.search index: %w(index1 index2), type: 'teammate', body: search.to_hash, ignore_unavailable: true
```

**Please consult the fully covered RSpec examples for more samples**

