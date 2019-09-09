#
# 重複をDBの制約でチェックします。
#
module DuplicationChecker
  class Duplication < ActiveRecord::Base

    scope :range_to, ->(time){where("created_at < ?", time)}
    scope :target, ->(duplication_key){where(duplication_key: duplication_key)}

    def self.create_check_data(duplication_key)
      duplication = Duplication.new
      duplication.duplication_key = duplication_key
      duplication.save!
    end

    def self.clean_data(time = Time.now - 1.hour)
      Duplication.range_to(time).delete_all
    end

    def self.clean_target_data(duplication_key, time)
      Duplication.target(duplication_key).range_to(time).delete_all
    end
  end
end
