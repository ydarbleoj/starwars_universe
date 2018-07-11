class ObjectCreator

  def initialize(object, res)
    @object = object.constantize
    @res    = res
    @obj    = object.downcase
    @obj_id = object.downcase + '_id'
  end

  def build
    @new_object = @object.new(@res.merge({@obj_id => parse_url_id}))

    if valid?
      @new_object.save!
      @new_object.id
    else
      return
    end
  end

  private
  def parse_url_id
    /\d+/.match(@res['url']).try(:[], 0).to_i
  end

  def valid?
    @new_object.as_json.except('id', 'created_at', 'updated_at', @obj_id) == @res
  end
end