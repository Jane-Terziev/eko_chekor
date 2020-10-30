EkoChekor::Container.boot(:concurrent) do |app|
  init do
    Dir[File.join(Rails.root, 'lib', 'util', 'concurrent', '*.rb')].each do |file|
      require File.join(File.dirname(file), File.basename(file, File.extname(file)))
    end
  end
end
