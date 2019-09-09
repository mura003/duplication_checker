require 'active_support/core_ext'
require 'active_record'

module DuplicationChecker
  module Checkable
    #
    # 重複チェックします。
    # 実態はDB制約によるチェックになります。
    # options
    # cleaner: trur or false (default: false)
    #         処理前にテーブルを一度クリアしまう。条件ago
    #
    # ago: default(5病)
    #      cleanerによって削除される時間を指定します。
    #      デフォルトは5秒以上前のデータです。
    #
    # sufix: duplication_keyに時間のsufixを付加します。
    #        キーだけで重複チェックが無理な場合に使用します。
    #        sufixを使用する場合はcleanerとの併用を推奨します。
    #
    def check_duplicate(duplication_key, options={})
      default_options = {cleaner: false, ago: 5.second.ago}
      merged_options = default_options.merge(options)

      key = (merged_options[:sufix].present? && merged_options[:sufix]) ? add_sufix(duplication_key) : duplication_key

      begin
        Duplication.clean_target_data(key, merged_options[:ago]) if merged_options[:cleaner]
        Duplication.create_check_data(key)
        yield
      rescue ActiveRecord::StatementInvalid => e
        if Duplication.target(key).first.present?
          raise DuplicationChecker::InvalidDuplicate
        else
          raise e
        end
      end
    end

    #
    # 重複チェックしたいキーにsufixを付加します。
    # sufixは「_年月日時分」になります。
    #
    def add_sufix(key)
      "#{key}_#{Time.now.strftime('%Y%m%d_%H%M')}"
    end
  end
end
