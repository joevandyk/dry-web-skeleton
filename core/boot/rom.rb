require "rom"
require "rom-repository"

AppPrototype::Container.namespace "persistence" do |container|
  ROM.use :auto_registration
  ROM.setup :sql, container.options.database_url

  %w(relations commands).each do |type|
    Dir[container.root.join("lib/persistence/#{type}/**/*.rb")].each(&method(:require))
  end

  container.register "rom", ROM.finalize.container

  container.require "core/container/persistence"
end
