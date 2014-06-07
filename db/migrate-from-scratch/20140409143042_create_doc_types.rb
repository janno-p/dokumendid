class CreateDocTypes < ActiveRecord::Migration
  def change
    create_table :doc_type, :primary_key => 'doc_type' do |t|
      t.integer :super_type_fk
      t.integer :level
      t.string :type_name, limit: 200
    end
  end
end
