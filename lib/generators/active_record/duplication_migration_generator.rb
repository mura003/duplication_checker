require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class DuplicationMigrationGenerator < Base
      source_root File.expand_path("../templates", __FILE__)
      argument :name, :type => :string, :default => "add_duplications_table"

      def create_migration_file
        migration_template "migration.rb", "db/migrate/#{file_name}.rb"
      end

      protected

      def duplication_table_name
        DuplicationChecker::Duplication.table_name
      end
    end
  end
end
