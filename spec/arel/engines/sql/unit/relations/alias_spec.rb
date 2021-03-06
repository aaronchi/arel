require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Alias do
    before do
      @relation = Table.new(:users)
    end

    describe '#to_sql' do
      describe 'when there is no ambiguity' do
        it 'does not alias table names anywhere a table name can appear' do
          sql = @relation                 \
            .where(@relation[:id].eq(1))  \
            .order(@relation[:id])        \
            .project(@relation[:id])      \
            .group(@relation[:id])        \
            .alias                        \
          .to_sql

          adapter_is :mysql do
            sql.should be_like(%Q{
              SELECT `users`.`id`
              FROM `users`
              WHERE `users`.`id` = 1
              GROUP BY `users`.`id`
              ORDER BY `users`.`id` ASC
            })
          end

          adapter_is_not :mysql do
            sql.should be_like(%Q{
              SELECT "users"."id"
              FROM "users"
              WHERE "users"."id" = 1
              GROUP BY "users"."id"
              ORDER BY "users"."id" ASC
            })
          end
        end
      end
    end
  end
end
