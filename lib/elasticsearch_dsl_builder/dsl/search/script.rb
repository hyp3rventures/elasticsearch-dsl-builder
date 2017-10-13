module ElasticsearchDslBuilder
  module DSL
    module Search
      class Script
        def lang(lang)
          raise ArgumentError, 'lang must be a String' unless lang.instance_of?(String)
          @lang = lang
          self
        end

        def source(source)
          raise ArgumentError, 'can be inline or file script. not both' if @file
          raise ArgumentError, 'source must be a String' unless source.instance_of?(String)
          @source = source
          self
        end

        def file(file)
          raise ArgumentError, 'can be inline or file script. not both' if @source
          raise ArgumentError, 'file must be a String' unless file.instance_of?(String)
          @file = file
          self
        end

        def params(params)
          raise ArgumentError, 'params must be a hash' unless params.instance_of?(Hash)
          @params = params
          self
        end

        def to_hash
          script = {}
          @lang ||= 'painless'
          script.update(lang: @lang, source: @source) if @source
          script.update(file: @file) if @file
          script.update(params: @params) if @params
          script
        end
      end
    end
  end
end
