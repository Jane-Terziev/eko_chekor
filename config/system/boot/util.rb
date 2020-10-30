EkoChekor::Container.boot(:util) do
  init do
    Dir[File.join(Rails.root, 'lib', 'util', '*.rb')].each do |file|
      require File.join(File.dirname(file), File.basename(file, File.extname(file)))
    end

    register('util.contract_validator', memoize: true) { ContractValidator.new }
  end
end
