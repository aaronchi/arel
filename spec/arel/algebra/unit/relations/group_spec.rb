require File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Group do
    before do
      @relation = Table.new(:users)
      @attribute = @relation[:id]
    end
  end
end
