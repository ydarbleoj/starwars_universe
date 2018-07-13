class ObjectCreator

  def initialize(object, res)
    @object = object.constantize
    @res    = res.transform_keys!(&:downcase)
    @obj    = object.downcase
    @obj_id = object.downcase + '_id'
  end

  def build
    clean_values
    @new_object = @object.new(@res.merge({@obj_id => parse_url_id}))

    if valid? && !exist?
      @new_object.save!
      @new_object.id
    else
      return
    end
  end

  private
  def clean_values
    return if @object != 'Film'
    @res.inject({}) { |h, (k,v)| h[k] = v.gsub(/\r\n?/, ' ') }
  end

  def parse_url_id
    /\d+/.match(@res['url']).try(:[], 0).to_i
  end

  def valid?
    @new_object.as_json.except('id', 'created_at', 'updated_at', @obj_id) == @res
  end

  def exist?
    @object.where(@obj_id +  ' = ?', @new_object.send(@obj_id)).first
  end
end