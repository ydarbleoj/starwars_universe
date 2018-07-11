class PageBuild

  def initialize(page, object)
    @page    = page
    @object  = object.constantize
    @obj_id  = (object.downcase + '_id')
  end

  def execute
    { next: @page.next, previous: @page.previous, results: grab_objects }
  end

  private
  def grab_objects
    @object.where(id: @page.ids.map(&:to_i)).as_json
      .map { |x| x.except('id', @obj_id, 'created_at', 'updated_at') }
  end

end