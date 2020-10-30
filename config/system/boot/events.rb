EkoChekor::Container.boot(:events) do |app|
  init do
    Dir[File.join(Rails.root, 'lib', 'util', 'events', '*.rb')].each do |file|
      require File.join(File.dirname(file), File.basename(file, File.extname(file)))
    end
  end

  start do
    EventSubscriptionManager.new.call(app['events.publisher'])
  end
end
