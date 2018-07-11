class CachePageInfo

  def initialize(query, object, res)
    @query  = query
    @object = object
    @res    = res
  end

  def execute
    add_objects
    update_cache
  end

  private
  def add_objects
    @ids = []
    @res['results'].each do |res|
      id = ObjectCreator.new(@object, res).build
      @ids << id if id
    end
  end

  def update_cache
    PageCache.create(
      url: @query, previous: @res['previous'], next: @res['next'], ids: @ids)
  end
end