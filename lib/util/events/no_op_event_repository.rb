class NoOpEventRepository
  def add_to_stream(*args)
    self
  end

  def link_to_stream(*args)
    self
  end

  def delete_stream(*_args)
    self
  end

  def has_event?(_event_id)
    false
  end

  def last_stream_event(_stream)
    nil
  end

  def read(_specification)
    nil
  end

  def count(_specification)
    0
  end

  def update_messages(_messages)
    self
  end

  def streams_of(event_id)
    []
  end

  def append_to_stream(*args)
    self
  end
end
