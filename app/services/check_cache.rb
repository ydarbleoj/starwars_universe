class CheckCache

  def initialize(query, object)
    @query  = query
    @object = object
  end

  def execute
    page = PageCache.find_by_url(@query)
    if page
      response = PageBuild.new(page, @object).execute
    else
      response = StarWarsApi.new(@query).call.parsed_response
      CachePageInfo.new(@query, @object, response).execute
    end
    response
  end
end