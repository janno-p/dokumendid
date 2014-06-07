class CreateAtrTypeSelectionValues < ActiveRecord::Migration
  def change
    create_table :atr_type_selection_value, :primary_key => 'atr_type_selection_value' do |t|
      t.integer :doc_attribute_type_fk
      t.string :value_text
      t.integer :orderby
    end
  end
end
