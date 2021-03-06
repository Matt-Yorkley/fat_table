require 'spec_helper'

module FatTable
  describe Table do
    describe 'order_by' do
      it 'should be able to sort its rows on one column' do
        aoh = [
          { a: '5', 'Two words' => '20', c: '3,123', d: 'apple' },
          { a: '4', 'Two words' => '5', c: '6,412', d: 'orange' },
          { a: '7', 'Two words' => '8', c: '$1,888', d: 'apple' }
        ]
        tab = Table.from_aoh(aoh).order_by(:a)
        expect(tab.rows[0][:a]).to eq 4
      end

      it 'should be able to sort its rows on multiple columns' do
        aoh = [
          { a: '5', 'Two words' => '20', c: '3,123', d: 'apple' },
          { a: '4', 'Two words' => '5', c: '6,412', d: 'orange' },
          { a: '7', 'Two words' => '8', c: '$1,888', d: 'apple' }
        ]
        tab = Table.from_aoh(aoh).order_by(:d, :c)
        expect(tab.rows[0][:a]).to eq 7
      end

      it 'should be able to reverse sort its rows on one column' do
        aoh = [
          { a: '5', 'Two words' => '20', c: '3,123', d: 'apple' },
          { a: '4', 'Two words' => '5', c: '6,412', d: 'orange' },
          { a: '7', 'Two words' => '8', c: '$1,888', d: 'apple' }
        ]
        tab = Table.from_aoh(aoh).order_by(:d!)
        expect(tab.rows[0][:d]).to eq 'orange'
        expect(tab.rows[2][:d]).to eq 'apple'
      end

      it 'should sort its rows on mixed forward and reverse columns' do
        aoh = [
          { a: '5', 'Two words' => '20', c: '3,123', d: 'apple' },
          { a: '4', 'Two words' => '5', c: 6412, d: 'orange' },
          { a: '7', 'Two words' => '8', c: '$1,888', d: 'apple' }
        ]
        tab = Table.from_aoh(aoh).order_by(:d!, :c)
        expect(tab.rows[0][:d]).to eq 'orange'
        expect(tab.rows[1][:d]).to eq 'apple'
        expect(tab.rows[1][:c]).to eq 1888
        expect(tab.rows[2][:d]).to eq 'apple'
      end
    end
  end
end
