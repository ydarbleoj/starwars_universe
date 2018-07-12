class CheckCache

  def initialize(query, object)
    @query     = query
    @object    = object
  end

  def page_info
    page = PageCache.find_by_url(@query)
    if page
      response = PageBuild.new(page, @object).execute
    else
      response = StarWarsApi.new(@query).call.parsed_response
      CachePageInfo.new(@query, @object, response).execute
    end
    response
  end

  def record_info
    url = @query.split('v1')[1]
    response = StarWarsApi.new(url).call.parsed_response
    ObjectCreator.new(@object, response).build
    response
  end

end